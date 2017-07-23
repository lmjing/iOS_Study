//
//  Food.swift
//  0718_BaeminFoodList
//
//  Created by woowabrothers on 2017. 7. 19..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//
 
import Foundation

class FoodSection {
    enum FoodType {
        case Main, Soup, Course, Side

        struct Section {
            let url: String
            let index: Int
            let title: String
            let description: String
        }
    
        var section: Section? {
        switch self {
        case .Main:
            return Section(url: "main", index: 0, title: "메인반찬", description: "담기만 하면 완성되는 메인반찬")
        case .Soup:
            return Section(url: "soup", index: 1, title: "국・찌개", description: "김이 모락모락 국・찌개")
        case .Course:
            return Section(url: "course", index: 2, title: "반찬세트", description: "고민없이 한 번에 반찬세트")
        case .Side:
            return Section(url: "side", index: 3, title: "밑반찬", description: "언제 먹어도 든든한 밑반찬")
        default:
            return nil
            }
        }
    }
    
    public private(set) var foodList = [Food]()
    public private(set) var foodType: FoodType
    
    init(foodType: FoodType) {
        self.foodType = foodType
        getDataFromURL()
    }
    
    func getDataFromURL() {
        DataTask().getSectionData(input_url: (foodType.section?.url)!, completionHandler: { (complete:[[String:Any]]) in
            for food in complete {
                self.foodList.append(Food(food: food))
            }
            NotificationCenter.default.post(name: NSNotification.Name("init"), object: self, userInfo: ["type":self.foodType])
        })
    }
}

class FoodAllList {
    static let instance = FoodAllList()
    
    public private(set) var allOfFoodList = [FoodSection]()
    
    private init() {
        self.allOfFoodList.append(FoodSection(foodType: FoodSection.FoodType.Main))
        self.allOfFoodList.append(FoodSection(foodType: FoodSection.FoodType.Soup))
        self.allOfFoodList.append(FoodSection(foodType: FoodSection.FoodType.Course))
        self.allOfFoodList.append(FoodSection(foodType: FoodSection.FoodType.Side))
    }
}

class Food {
    var detail_hash: String
    var title: String
    var description: String
    var s_price: String
    var n_price: String?
    var badge: [String]?
    var image: String
    
    init(food: [String:Any]) {
        detail_hash = food["detail_hash"] as! String
        title = food["title"] as! String
        description = food["description"] as! String
        s_price = food["s_price"] as! String
        image = food["image"] as! String
        
        if let temp = food["n_price"] {
            n_price = temp as! String
        }else {
            n_price = nil
        }
        
        if let temp = food["badge"] {
            badge = temp as! [String]
        }else {
            badge = nil
        }
    }
    
    init(food: Food) {
        detail_hash = food.detail_hash
        title = food.title
        description = food.description
        s_price = food.s_price
        image = food.image
        
        if let temp = food.n_price {
            n_price = temp
        }else {
            n_price = nil
        }
        
        if let temp = food.badge {
            badge = temp
        }else {
            badge = nil
        }
    }
}

class DetailFood: Food {
    let top_image: String
    let thumb_images: [String]
    let product_description: String
    let point: String
    let delivery_info: String
    let delivery_fee: String
    let prices: [String]
    let detail_section: [String]
    var detailImageDic: [Int : String]
    
    init(originalFood: Food, detailFood: [String:Any]) {
        top_image = detailFood["top_image"] as! String
        thumb_images = detailFood["thumb_images"] as! [String]
        product_description = detailFood["product_description"] as! String
        point = detailFood["point"] as! String
        delivery_info = detailFood["delivery_info"] as! String
        delivery_fee = detailFood["delivery_fee"] as! String
        prices = detailFood["prices"] as! [String]
        detail_section = detailFood["detail_section"] as! [String]
        detailImageDic = [Int : String]()
        
        super.init(food: originalFood)
        
        DataTask().downloadDetailImage(imageUrls: self.detail_section, hash: self.detail_hash, completionHandler: { (complete: [Int : String]) in
            self.detailImageDic = complete
            print("noti post")
            NotificationCenter.default.post(name: NSNotification.Name("detailImage"), object: self, userInfo: ["detailImageDic":self.detailImageDic])
        })
    }
}
