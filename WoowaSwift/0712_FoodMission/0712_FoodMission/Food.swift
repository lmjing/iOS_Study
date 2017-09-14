//
//  Food.swift
//  0712_FoodMission
//
//  Created by woowabrothers on 2017. 7. 12..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation

class Food {
    let restaurant: String
    var capacity: Int
    var price: Int
    let name: String
    let manufacturingDate: Date

    init(restaurant: String, capacity: Int, price: Int, name: String, manufacturingDate: Date) {
        self.restaurant = restaurant
        self.capacity = capacity
        self.price = price
        self.name = name
        self.manufacturingDate = manufacturingDate
    }
}

/*
 TODO: 세트 메뉴 해보기
 그리고 자판기에서 치킨, 햄버거, 피자 구매시 세트 여부 확인 할 것
 */

class SetMenuFood: Food {
    enum Drink: Int {
        case Coke = 1000, Sprite = 1100, Hwanta = 1200
    }
    
    enum SideMenu: Int {
        case FrenchFries = 2000, ChickenNuggets = 3000
    }
    var drink: Drink?
    var side: SideMenu?
    var set: Bool
    
    override init(restaurant: String, capacity: Int, price: Int, name: String, manufacturingDate: Date) {
        self.set = false
        self.side = nil
        self.drink = nil
        super.init(restaurant: restaurant, capacity: capacity, price: price, name: name, manufacturingDate: manufacturingDate)
    }
    
    func setOption(set: Bool) {
        if set == true {
            self.set = true
        }else {
            self.set = false
            self.drink = nil
            self.side = nil
        }
    }
    
    func setSideMenu(side: SideMenu, drink: Drink) {
        if set == true {
            self.side = side
            self.drink = drink
            self.price += (side.rawValue + drink.rawValue)
        }
    }
}

class Chicken: SetMenuFood {
    var bone: Bool
    
    init(restaurant: String, capacity: Int, price: Int, name: String, manufacturingDate: Date, bone: Bool) {
        self.bone = bone
        super.init(restaurant: restaurant, capacity: capacity, price: price, name: name, manufacturingDate: manufacturingDate)
    }
}


//class Chicken: Food {
//    var bone: Bool
//    
//    init(restaurant: String, capacity: Int, price: Int, name: String, manufacturingDate: Date, bone: Bool) {
//        self.bone = bone
//        super.init(restaurant: restaurant, capacity: capacity, price: price, name: name, manufacturingDate: manufacturingDate)
//    }
//}

class Pizza: Food {
    var cheeseCrust: Bool
    
    init(restaurant: String, capacity: Int, price: Int, name: String, manufacturingDate: Date, cheeseCrust: Bool) {
        self.cheeseCrust = cheeseCrust
        super.init(restaurant: restaurant, capacity: capacity, price: price, name: name, manufacturingDate: manufacturingDate)
    }
}

class Bossam: Food {
    var noodle: Bool
    
    init(restaurant: String, capacity: Int, price: Int, name: String, manufacturingDate: Date, noodle: Bool) {
        self.noodle = noodle
        super.init(restaurant: restaurant, capacity: capacity, price: price, name: name, manufacturingDate: manufacturingDate)
    }
}

class Hambuger: Food {
    
    override init(restaurant: String, capacity: Int, price: Int, name: String, manufacturingDate: Date) {
        super.init(restaurant: restaurant, capacity: capacity, price: price, name: name, manufacturingDate: manufacturingDate)
    }
}

class Dduckppokki: Food {
    enum Spicy {
        case low, mid, high
    }
    let spicy: Spicy
    
    init(restaurant: String, capacity: Int, price: Int, name: String, manufacturingDate: Date, spicy: Spicy) {
        self.spicy = spicy
        super.init(restaurant: restaurant, capacity: capacity, price: price, name: name, manufacturingDate: manufacturingDate)
    }
}
