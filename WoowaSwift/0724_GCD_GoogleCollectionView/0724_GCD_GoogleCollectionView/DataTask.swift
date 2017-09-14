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
        DispatchQueue.global().async {
            URLSession(configuration: URLSessionConfiguration.default).dataTask(with:
            URL(string: "http://125.209.194.123/doodle.php")!) {
                (data, response, error) in
                let jsonDict: [[String:String]] = try! JSONSerialization.jsonObject(with: data!, options: []) as! [[String:String]]
                
                NotificationCenter.default.post(name: NSNotification.Name("data"), object: self, userInfo: ["data":jsonDict])
//                for item in jsonDict {
//                    //                self.getImage(title: item["title"]!, url: item["image"]!)
//                    self.getImage2(title: item["title"]!, url: item["image"]!)
//                }
            }.resume()
        }
    }
    
    func getImage(title: String, url: String) {
        DispatchQueue.global().async {
            URLSession(configuration: URLSessionConfiguration.default).downloadTask(with: URL(string: url)!) {
                (data, response, error) in
                
                let documentsURL = FileManager.default.urls(for: .cachesDirectory , in: .userDomainMask)[0]
                let destinationFileUrl = documentsURL.appendingPathComponent(title+".jpg")
//                print(destinationFileUrl)
                
                    if let tempLocalUrl = data, error == nil {
                        do {
                            try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                            
                            NotificationCenter.default.post(name: NSNotification.Name("imageDown"), object: self, userInfo: ["index" : title])
                        } catch (let writeError) {
                            print("Error creating a file \(destinationFileUrl) : \(writeError)")
                        }
                    }
            
                }.resume()
        }
        
//            DispatchQueue.global().async {
//                URLSession(configuration: URLSessionConfiguration.default).dataTask(with: URL(string: url)!) {
//                    (data, response, error) in
//                
//                    let documentsURL = FileManager.default.urls(for: .cachesDirectory , in: .userDomainMask)[0]
//                    let destinationFileUrl = documentsURL.appendingPathComponent(title+".jpg")
//                
//                    if let data = data, error == nil {
//                        do {
//                            NotificationCenter.default.post(name: NSNotification.Name("imageDown"), object: self, userInfo: ["data" : data, "index":title])
//                        }catch (let writeError) {
//                            print("Error creating a file \(destinationFileUrl) : \(writeError)")
//                        }
//                    }
//                }.resume()
//            }
//        }
    }
    
    func getImage2(title: String, url: String) {
        DispatchQueue.global().async {
            URLSession(configuration: URLSessionConfiguration.default).dataTask(with: URL(string: url)!) {
                (data, response, error) in
        
                let documentsURL = FileManager.default.urls(for: .cachesDirectory , in: .userDomainMask)[0]
                let destinationFileUrl = documentsURL.appendingPathComponent(title+".jpg")
        
                if let data = data, error == nil {
                    do {
                        NotificationCenter.default.post(name: NSNotification.Name("imageDown"), object: self, userInfo: ["data" : data, "index":Int(title)])
                    }catch (let writeError) {
                        print("Error creating a file \(destinationFileUrl) : \(writeError)")
                    }
                }
            }.resume()
        }
    }
    
    func getImage3(title: String, url: String, completion: @escaping (Data)-> Void)
    {
        DispatchQueue.global().async {
            URLSession(configuration: URLSessionConfiguration.default).dataTask(with: URL(string: url)!) {
                (data, response, error) in
                
                let documentsURL = FileManager.default.urls(for: .cachesDirectory , in: .userDomainMask)[0]
                let destinationFileUrl = documentsURL.appendingPathComponent(title+".jpg")
                
                if let data = data, error == nil {
                    do {
                        completion(data)
                    }catch (let writeError) {
                        print("Error creating a file \(destinationFileUrl) : \(writeError)")
                    }
                }
                }.resume()
        }
    }
}
