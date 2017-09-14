//
//  SessionData.swift
//  0718_NetworkApp
//
//  Created by woowabrothers on 2017. 7. 18..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation

class DataTask {
    func getCall() {
        print("getCall")
        URLSession(configuration: URLSessionConfiguration.default).dataTask(with:
        URL(string: "http://52.78.212.27:8080/woowa/main")!) {
            (data, response, error) in
            let resultHTML = String(data: data!, encoding: String.Encoding.utf8)
            print(resultHTML)
            
            NotificationCenter.default.post(name: NSNotification.Name("GET"), object: self, userInfo: ["result":resultHTML])
        }.resume()
    }
    
    func getPost(input: String) {
        print("getCall")
        var request = URLRequest(url: URL(string: "https://hooks.slack.com/services/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")!)
        request.httpMethod = "POST"
        let message = [
                "username": "mj-webhook",
                "icon_url": "",
                "icon_emoji": "우와오우왕",
                "text": input,
                "channel": ""
        ]
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        if let jsonData = try? JSONSerialization.data(withJSONObject: message, options: []) {
            request.httpBody = jsonData
            URLSession.shared.dataTask(with: request) {
                (data, response, error) in
            
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(response!)")
                    print("error = \(error!)")
                }
            
                NotificationCenter.default.post(name: NSNotification.Name("POST"), object: self, userInfo: ["result":"success"])
                }.resume()
        }
    }
}
