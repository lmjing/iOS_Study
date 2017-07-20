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
                self.foodList.append(Food(title: food["title"], description: food["description"], s_price: food["s_price"], n_price: food["n_price"] ?? nil, badge: food["badge"] as? [Any], image: food["image"]))
            }
            print("foodInfo")
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
    let title: String
    let description: String
    let s_price: String
    let n_price: String?
    let badge: [String]?
    let image: String
    
//    let top_image: String
//    let thumb_images: [String]
//    let product_description: String
//    let point: String
//    let delivery_info: String
//    let delivery_fee: String
//    let prices: [String]
//    let detail_section: [String]
    
    init(title: Any, description: Any, s_price: Any, n_price: Any?, badge: [Any]?, image: Any) {
        self.title = title as! String
        self.description = description as! String
        self.s_price = s_price as! String
        self.image = image as! String
        
        if n_price != nil {
            self.n_price = n_price! as? String
        }else {
            self.n_price = nil
        }
        
        if badge != nil {
            var temp = [String]()
            for b in badge! {
                temp.append(b as! String)
            }
            self.badge = temp
        }else {
            self.badge = nil
        }
    }
}
