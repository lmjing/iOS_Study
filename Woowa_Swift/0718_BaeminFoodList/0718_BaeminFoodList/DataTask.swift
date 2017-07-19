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
    
    func getCall(input_url: String) {
        let url = deafaultUrl + input_url
//        URLSession(configuration: URLSessionConfiguration.default).dataTask(with:
//        URL(string: url)!) {
//            (data, response, error) in
//            let resultHTML = String(data: data!, encoding: String.Encoding.utf8)
//            print(resultHTML)
//            
//            NotificationCenter.default.post(name: NSNotification.Name("GET"), object: self, userInfo: ["result":resultHTML])
//            }.resume()
        
        Alamofire.request(url).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
//            
//            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                print("Data: \(utf8Text)") // original server data as UTF8 string
//            }
        }
    }
}
