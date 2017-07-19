//
//  DataTask.swift
//  0718_BaeminFoodList
//
//  Created by woowabrothers on 2017. 7. 19..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation
import Alamofire

class DataTask {
    let deafaultUrl = "http://52.78.212.27:8080/woowa/"
    
    func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    func getSectionData(input_url: String, completionHandler: @escaping ([[String:Any]]) -> Void) {
        let url = deafaultUrl + input_url
        Alamofire.request(url).responseJSON { response in
            if let jsonDict = response.result.value as? [[String:Any]] {
                completionHandler(jsonDict)
                //구: 이미지 다운 코드
                //                for food in jsonDict {
                //                    print("image")
                //                    self.downloadimage(imageName: food["detail_hash"] as! String, imageurl: food["image"] as! String)
                //                }
            }
        }
    }
    
//    구 : 이미지 다운 코드
//    func downloadimage(imageName: String, imageurl: String) {
//        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
//            let documentsURL = FileManager.default.urls(for: .cachesDirectory , in: .userDomainMask)[0]
//            let fileURL = documentsURL.appendingPathComponent(imageName+".jpg")
//            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
//        }
//        Alamofire.download(imageurl, to: destination).response { response in
//            if response.error != nil {
//                print(response.error!)
//            }
//        }
//    }
}
