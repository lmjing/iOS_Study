//
//  ViewController.swift
//  0724_GCD_GoogleCollectionView
//
//  Created by woowabrothers on 2017. 7. 24..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var imageList = [Int:UIImage]()
    var jsonDict = [[String:String]]()
    let dataTask = DataTask()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = true
        
        dataTask.getData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setCount), name: NSNotification.Name("data"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setImageView), name: NSNotification.Name("imageDown"), object: nil)
    }
    
    func setCount(notification: Notification) {
        let jsonDict = notification.userInfo?["data"] as! [[String:String]]
        self.jsonDict = jsonDict
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func setImageView(notification: Notification) {
        let index = notification.userInfo?["index"] as! Int
        let data = notification.userInfo?["data"] as! Data
        let image = UIImage(data: data)
        imageList[index] = image
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

//    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
//        for indexPath in indexPaths{
//            dataTask.getImage2(title: jsonDict[indexPath.row]["title"]!, url: jsonDict[indexPath.row]["image"]!)
//        }
//    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        cell.indexLabel.text = String(indexPath.row + 1)
        //cell.configureCell(index: indexPath.row)
        if let image = imageList[indexPath.row + 1] {
            cell.configureCell2(image: image)
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jsonDict.count
    }
}
