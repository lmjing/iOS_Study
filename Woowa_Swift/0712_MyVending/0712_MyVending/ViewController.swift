//
//  ViewController.swift
//  0712_MyVending
//
//  Created by woowabrothers on 2017. 7. 12..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var vendingMachine = FoodVendingMachine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let chicken = Chicken(restaurant: "굽네치킨", capacity: 0, price: 10000, name: "고추바사삭", manufacturingDate: Date(),bone: true)
        let pizza = Pizza(restaurant: "피자헛", capacity: 20, price: 12000, name: "피자", manufacturingDate: Date(), cheeseCrust: true)
        let bossam = Bossam(restaurant: "원할머니보쌈", capacity: 30, price: 13000, name: "보쌈정식", manufacturingDate: Date(), noodle: true)
        let hambuger = Hambuger(restaurant: "맥도날드", capacity: 40, price: 14000, name: "빅맥버거", manufacturingDate: Date())
        let dduckppokki = Dduckppokki(restaurant: "엽기떡볶이", capacity: 50, price: 15000, name: "엽떡", manufacturingDate: Date(), spicy: .high)
        
        vendingMachine.add(food: chicken)
        vendingMachine.add(food: pizza)
        vendingMachine.add(food: bossam)
        vendingMachine.add(food: hambuger)
        vendingMachine.add(food: dduckppokki)
        vendingMachine.add(food: dduckppokki)
        
        vendingMachine.add(money: 30000)
        print("잔돈 : " + String(vendingMachine.buy(food: bossam)))
        print("잔돈 : " + String(vendingMachine.buy(food: hambuger)))
        let change = vendingMachine.buy(food: chicken)
        if change != -1 {
            print("잔돈 : " + String(change))
        }
        
        
        print("-----------모든 물품 재고량----------")
        for (foodName, capacity) in vendingMachine.getMenuList() {
            print(foodName + "의 재고량 : " + String(capacity))
        }
        
        print("-----------구매 가능한 목록----------")
        for food in vendingMachine.getAvailablePurchaseFood(money: 15000) {
            print(food.name + " : " + String(food.price) + "원")
        }
        
        print("-----------구매 완료 목록----------")
        for result in vendingMachine.getBuyList() {
            print(result)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

