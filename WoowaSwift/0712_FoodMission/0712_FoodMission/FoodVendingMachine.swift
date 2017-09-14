//
//  FoodVendingMachine.swift
//  0712_FoodMission
//
//  Created by woowabrothers on 2017. 7. 12..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation

class FoodVendingMachine {
    var menuList: [String:Food]
    var buyList: [String:Int]
    var balance: Int
    
    init() {
        menuList = [:]
        buyList = [:]
        balance = 0
    }
    
    func add(money: Int) {
        balance += money
        print("현재 금액 : "+String(balance))
    }
    
    func add(food: Food) {
        let foodName = food.restaurant + "-" + food.name
        
        if let exist = menuList[foodName] {
            exist.capacity += food.capacity
            print(foodName + "의 재고량이 " + String(exist.capacity) + "로 증가하였습니다.")
        }else {
            menuList[foodName] = food
        }
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
    
    func buy(food: Food) -> Int {
        let foodName = food.restaurant + "-" + food.name
        
        if let exist = menuList[foodName] {
            balance -= exist.price
            if balance >= 0 {
                
                exist.capacity -= 1
                print(foodName + " 구매완료")

                return balance
            }else {
                print("금액이 부족합니다. 돈을 더 넣어주세요 :)")
                return -1
            }
        }else {
            print("error : 찾으시는 음식이 존재하지 않습니다.")
        }
        
        return -1
    }
    
    //그냥 String배열로 리턴
    func getBuyList() -> [String] {
        var result = [String]()
        for (foodName, price) in buyList {
            result.append(foodName + "     " + String(price) + " 원")
        }
        return result
    }
    
}
