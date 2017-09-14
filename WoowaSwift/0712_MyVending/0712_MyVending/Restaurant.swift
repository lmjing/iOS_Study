//
//  Restaurant.swift
//  0712_MyVending
//
//  Created by woowabrothers on 2017. 7. 25..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation

class Restaurant: NSObject, NSCoding {
    let name: String
    var menu: [Food]
    var capacity: Int
    
    init(name: String) {
        self.name = name
        menu = [Food]()
        capacity = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "restaturantName") as! String
        menu = aDecoder.decodeObject(forKey: "restaturantMenu") as! [Food]
        capacity = aDecoder.decodeInteger(forKey: "restaturantCapacity")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "restaturantName")
        aCoder.encode(menu, forKey: "restaturantMenu")
        aCoder.encode(capacity, forKey: "restaturantCapacity")
    }
    
    public func addFoodMenu(food: Food) {
        var exist = false
        for temp in menu {
            if temp == food {
                temp.capacity += food.capacity
                exist = true; break
            }
        }
        if exist == false {
            menu.append(food)
            print("없어서 넣었음")
        }
        
        self.capacity += food.capacity
    }
}
