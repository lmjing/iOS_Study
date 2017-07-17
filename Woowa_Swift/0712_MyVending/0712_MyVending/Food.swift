//
//  Food.swift
//  0712_FoodMission
//
//  Created by woowabrothers on 2017. 7. 12..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation

class Food: NSObject, NSCoding {
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

    override init() {
        restaurant = ""
        capacity = 0
        price = 0
        name = ""
        manufacturingDate = Date()
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(restaurant, forKey: "restaurant")
        aCoder.encode(capacity, forKey: "capacity")
        aCoder.encode(price, forKey: "price")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(manufacturingDate, forKey: "manufacturingDate")
    }

    required init?(coder aDecoder: NSCoder) {
        restaurant = aDecoder.decodeObject(forKey: "restaurant") as! String
        capacity = aDecoder.decodeInteger(forKey: "capacity")
        price = aDecoder.decodeInteger(forKey: "price")
        name = aDecoder.decodeObject(forKey: "name") as! String
        manufacturingDate = aDecoder.decodeObject(forKey: "manufacturingDate") as! Date
    }
}

class Chicken: Food {
    var bone: Bool

    init(restaurant: String, capacity: Int, price: Int, name: String, manufacturingDate: Date, bone: Bool) {
        self.bone = bone
        super.init(restaurant: restaurant, capacity: capacity, price: price, name: name, manufacturingDate: manufacturingDate)
    }

    override func encode(with aCoder: NSCoder) {
        aCoder.encode(bone, forKey: "bone")
        super.encode(with: aCoder)
    }

    required init?(coder aDecoder: NSCoder) {
        bone = aDecoder.decodeBool(forKey: "bone")
        super.init(coder: aDecoder)
    }
}

class Pizza: Food {
    var cheeseCrust: Bool

    init(restaurant: String, capacity: Int, price: Int, name: String, manufacturingDate: Date, cheeseCrust: Bool) {
        self.cheeseCrust = cheeseCrust
        super.init(restaurant: restaurant, capacity: capacity, price: price, name: name, manufacturingDate: manufacturingDate)
    }

    override func encode(with aCoder: NSCoder) {
        aCoder.encode(cheeseCrust, forKey: "cheeseCrust")
        super.encode(with: aCoder)
    }

    required init?(coder aDecoder: NSCoder) {
        cheeseCrust = aDecoder.decodeBool(forKey: "cheeseCrust")
        super.init(coder: aDecoder)
    }
}

class Bossam: Food {
    var noodle: Bool

    init(restaurant: String, capacity: Int, price: Int, name: String, manufacturingDate: Date, noodle: Bool) {
        self.noodle = noodle
        super.init(restaurant: restaurant, capacity: capacity, price: price, name: name, manufacturingDate: manufacturingDate)
    }

    override func encode(with aCoder: NSCoder) {
        aCoder.encode(noodle, forKey: "noodle")
        super.encode(with: aCoder)
    }

    required init?(coder aDecoder: NSCoder) {
        noodle = aDecoder.decodeBool(forKey: "noodle")
        super.init(coder: aDecoder)
    }
}

class Hambuger: Food {

    override init(restaurant: String, capacity: Int, price: Int, name: String, manufacturingDate: Date) {
        super.init(restaurant: restaurant, capacity: capacity, price: price, name: name, manufacturingDate: manufacturingDate)
    }

    override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class Dduckppokki: Food {
    enum Spicy: Int {
        case low = 0, mid, high
    }
    let spicy: Spicy

    init(restaurant: String, capacity: Int, price: Int, name: String, manufacturingDate: Date, spicy: Spicy) {
        self.spicy = spicy
        super.init(restaurant: restaurant, capacity: capacity, price: price, name: name, manufacturingDate: manufacturingDate)
    }

    override func encode(with aCoder: NSCoder) {
        aCoder.encode(spicy.rawValue, forKey: "spicy")
        super.encode(with: aCoder)
    }

    required init?(coder aDecoder: NSCoder) {
        spicy = Dduckppokki.Spicy(rawValue: Int(aDecoder.decodeCInt(forKey: "spicy")))!
        super.init(coder: aDecoder)
    }
}
