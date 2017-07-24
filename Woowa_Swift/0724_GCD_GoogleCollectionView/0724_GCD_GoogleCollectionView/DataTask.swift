//
//  DataTask.swift
//  0724_GCD_GoogleCollectionView
//
//  Created by woowabrothers on 2017. 7. 24..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation

class DataTask {
    func getData() {
        URLSession(configuration: URLSessionConfiguration.default).dataTask(with:
        URL(string: "http://125.209.194.123/doodle.php")!) {
            (data, response, error) in
            let jsonDict: [[String:String]] = try! JSONSerialization.jsonObject(with: data!, options: []) as! [[String:String]]
            
            for item in jsonDict {
                self.getImage(title: item["title"]!, url: item["image"]!)
            }
        }.resume()
    }
    
    func getImage(title: String, url: String) {
        URLSession(configuration: URLSessionConfiguration.default).downloadTask(with: URL(string: url)!) {
            (data, response, error) in
            
            let documentsURL = FileManager.default.urls(for: .cachesDirectory , in: .userDomainMask)[0]
            let destinationFileUrl = documentsURL.appendingPathComponent(title+".jpg")
            
            if let tempLocalUrl = data, error == nil {
                do {
                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                    NotificationCenter.default.post(name: NSNotification.Name("imageDown"), object: self, userInfo: ["path" : destinationFileUrl])
                } catch (let writeError) {
                    print("Error creating a file \(destinationFileUrl) : \(writeError)")
                }
            }
        }.resume()
    }
}
