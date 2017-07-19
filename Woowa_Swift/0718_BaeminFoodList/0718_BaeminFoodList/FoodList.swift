//
//  Food.swift
//  0718_BaeminFoodList
//
//  Created by woowabrothers on 2017. 7. 18..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation

class FoodList {
    static let instance = FoodList()
    
    enum FoodType: Int {
        case Main = 0, Soup = 1, Course = 2 , Side = 3
    }
    let typeList = ["main","soup","course","side"]
    
    var data = [Int : [[String:Any]]]()
    let headerDic: [FoodType.RawValue:(String,String)] = [
        FoodType.Main.rawValue : ("메인반찬","담기만 하면 완성되는 메인반찬"),
        FoodType.Soup.rawValue : ("국・찌개","김이 모락모락 국・찌개"),
        FoodType.Course.rawValue : ("반찬세트","고민없이 한 번에 반찬세트"),
        FoodType.Side.rawValue : ("밑반찬","언제 먹어도 든든한 밑반찬"),
    ]
    public private(set) var jsonSectionArray = [String:[[String:Any]]]()
    
    func getDataFromURL(){
        for type in typeList {
            DataTask().getCall(input_url: type, completionHandler: { (complete:[[String:Any]]) in
                self.jsonSectionArray[type] = complete
                print("foodInfo")
                NotificationCenter.default.post(name: NSNotification.Name("init"), object: self, userInfo: ["result":complete])
            })
        }
    }
    func getHeaderDic(type: FoodType.RawValue) -> (title: String, description: String) {
        return (title: headerDic[type]!.0, description: headerDic[type]!.1)
    }
    
    func getJsonArray(type: FoodType.RawValue) -> [[String:Any]] {
        return jsonSectionArray[typeList[type]]!
    }
    
    private func readJson(fileName: String) -> Array<Dictionary<String,Any>> {
        do {
            if let file = Bundle.main.url(forResource: fileName, withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? Array<Dictionary<String,Any>> {
                    return object
                } else if (json as? [Any]) != nil {
                    print("단순한 배열 형태")
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
}
