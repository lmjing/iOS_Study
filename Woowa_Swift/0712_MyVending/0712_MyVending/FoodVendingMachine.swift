//
//  FoodVendingMachine.swift
//  0712_FoodMission
//
//  Created by woowabrothers on 2017. 7. 12..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation

class FoodVendingMachine: NSObject, NSCoding {
    
    static var instance = FoodVendingMachine()
    var menuList: [String:Food]
    var buyList: [String:Int]
    var balance: Int
    
    private override init() {
        print("호출")
        menuList = [:]
        buyList = [:]
        balance = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        menuList = aDecoder.decodeObject(forKey: "menuList") as! [String:Food]
        buyList = aDecoder.decodeObject(forKey: "buyList") as! [String:Int]
        balance = aDecoder.decodeInteger(forKey: "balance")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(menuList, forKey: "menuList")
        aCoder.encode(buyList, forKey: "buyList")
        aCoder.encode(balance, forKey: "balance")
    }
    
    func add(money: Int) -> Int {
        balance += money
        print("현재 금액 : "+String(balance))
        
        return balance
    }
    
    func add(food: Food) {
        let foodName = food.restaurant + "-" + food.name
        
        if let exist = menuList[foodName] {
            exist.capacity += food.capacity
            print(food.capacity)
            print(foodName + "의 재고량이 " + String(exist.capacity) + "로 증가하였습니다.")
            print(exist.capacity, "exist.capacity")
            print(food.capacity, "food.capacity")
            
        }else {
            menuList[foodName] = food
            print(foodName + "추가")
        }
        NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: getMenuList())
    }
    
    func getMenuList() -> [String : Int] {
        var result: [String : Int] = [:]
        
        for (foodName, food) in menuList {
            result[foodName] = food.capacity
        }
        return result
    }
    
    func getAvailablePurchaseFood(money: Int) -> [Food] {
        var result = [Food]()
        
        for (_, food) in menuList {
            if(food.price <= money && food.capacity > 0) {
                result.append(food)
            }
        }
        return result
    }
    
    func buy(foodName: String) -> Int {
        //let foodName = food.restaurant + "-" + food.name
        if let exist = menuList[foodName] {
            if (menuList[foodName]?.price)! < balance {
                balance -= exist.price
                exist.capacity -= 1
                print(foodName + " 구매완료")
                buyList[foodName] = exist.price
                return balance
            }else {
                print("금액이 부족합니다. 돈을 더 넣어주세요 :)")
                return -1
            }
        }else {
            print("error : 찾으시는 음식이 존재하지 않습니다.")
            return -2
        }
    }
    
    //그냥 String배열로 리턴
    func getBuyList() -> [String:Int] {
        return buyList
    }
    
}
