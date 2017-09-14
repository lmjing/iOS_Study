//
//  DataTask.swift
//  0718_BaeminFoodList
//
//  Created by woowabrothers on 2017. 7. 19..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class DataTask {
    let deafaultUrl = "http://52.78.212.27:8080/woowa/"
    static let imageCache = AutoPurgingImageCache()
    
    func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    func getSectionData(input_url: String, completionHandler: @escaping ([[String : Any]]) -> Void) {
        let url = deafaultUrl + input_url
        Alamofire.request(url).responseJSON { response in
            if let jsonDict = response.result.value as? [[String : Any]] {
                completionHandler(jsonDict)
            }
        }
    }
    
    func getDetailData(hash: String, completionHandler: @escaping ([String : Any]) -> Void) {
        let url = deafaultUrl + "detail/" + hash
        Alamofire.request(url).responseJSON { response in
            if let jsonDict = response.result.value as? [String : Any] {
                let result = jsonDict["data"] as? [String : Any]
                completionHandler(result!)
            }
        }
    }
    
    func downloadDetailImage(imageUrls: [String], hash: String, completionHandler: @escaping ([Int : String]) -> Void) {
        var result = [Int : String]()
        for index in 0..<imageUrls.count {
            Alamofire.request(imageUrls[index]).responseImage { response in
                if let image = response.result.value {
                    let name = hash + String(index)
                    result[index] = name
                    DataTask.imageCache.add(image, withIdentifier: name)
                    
                    if index == imageUrls.count - 1 {
                        completionHandler(result)
                    }
//                    NotificationCenter.default.post(name: NSNotification.Name("detailImage"), object: self, userInfo: ["imageName":name])
                }
            }
        }
    }
}
