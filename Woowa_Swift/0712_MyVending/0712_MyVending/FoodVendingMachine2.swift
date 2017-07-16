//
//  FoodVendingMachine.swift
//  0712_FoodMission
//
//  Created by woowabrothers on 2017. 7. 12..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation

enum Menu: Int {
    case chicken = 1, pizza, bossam, haumbuger, dduckppokki
}

class FoodVendingMachine2: NSObject, NSCoding {
    
    static var instance = FoodVendingMachine2()
    var menuList: [Int:[String:Food]]
    var buyList: [Int:Int]
    var balance: Int
    
    private override init() {
        print("호출2")
        menuList = [:]
        buyList = [:]
        balance = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        menuList = aDecoder.decodeObject(forKey: "menuList") as! [Int:[String:Food]]
        buyList = aDecoder.decodeObject(forKey: "buyList") as! [Int:Int]
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
    
    func getAllCapcityList() -> [Int : Int] {
        var result: [Int : Int] = [:]
        
        for (menu, foodlist) in menuList {
            var allOfCapcity = 0
            for (_,food) in foodlist{
                allOfCapcity += food.capacity
            }
            result[menu] = allOfCapcity
        }
        return result
    }
    
    func add(food: Food) {
        let type:Menu? = getMenuType(food: food)
        let foodName = food.restaurant + "-" + food.name
        
        if let menu = type {
            if var existMenu = menuList[menu.rawValue] {
                if let existFood = existMenu[foodName] {
                    existFood.capacity += existFood.capacity
                }else {
                    existMenu[foodName] = food
                }
            }else {
                var appendFood = [String:Food]()
                appendFood[foodName] = food
                menuList[menu.rawValue] = appendFood
            }
            
            NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier2"), object: getAllCapcityList())
        }else { print("error") }
    }
    
    func getAvailablePurchaseFood(money: Int) -> [Food] {
        var result = [Food]()
        
        for (_, foodlist) in menuList {
            for (_,food) in foodlist {
                if(food.price <= money && food.capacity > 0) {
                    result.append(food)
                }
            }
        }
        return result
    }
    
    func buy(menu: Int) -> Int {
        //나중에 리스트 만들면 응용
//        let type:Menu? = getMenuType(food: food)
//        let foodName = food.restaurant + "-" + food.name
//        if let menu = type {
//            if let exist = menuList[menu.rawValue]![foodName] {
//                if (exist.price) < balance {
//                    balance -= exist.price
//                    exist.capacity -= 1
//                    buyList[menu.rawValue] = exist.price
//                    return balance
//                }else {
//                    print("금액이 부족합니다. 돈을 더 넣어주세요 :)")
//                    return -1
//                }
//            }else {
//                print("error : 찾으시는 음식이 존재하지 않습니다.")
//                return -2
//            }
//        }else {
//            return -3
//        }
        
        if let exist = menuList[menu]?.first?.value {
            if (exist.price) < balance {
                balance -= exist.price
                exist.capacity -= 1
                buyList[menu] = exist.price
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
    
    func getMenuType(food: Food) -> Menu?{
        var type:Menu? = nil
        if food.isKind(of: Chicken.self) {
            print("치킨타입")
            type = .chicken
        }else if food.isKind(of: Pizza.self) {
            print("피자타입")
            type = .pizza
        }else if food.isKind(of: Bossam.self) {
            print("보쌈타입")
            type = .bossam
        }else if food.isKind(of: Hambuger.self) {
            print("햄버거타입")
            type = .haumbuger
        }else if food.isKind(of: Dduckppokki.self) {
            print("떡볶이타입")
            type = .dduckppokki
        }
        return type
    }
    
    //그냥 String배열로 리턴
    func getBuyList() -> [Int:Int] {
        return buyList
    }
}
