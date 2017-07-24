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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = true
        
        DataTask().getData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setImageView), name: NSNotification.Name("imageDown"), object: nil)
    }
    
    func setImageView(notification: Notification) {
        self.collectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell
        cell.indexLabel.text = String(indexPath.row + 1)
        
        let documentsURL = FileManager.default.urls(for: .cachesDirectory , in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent(String(indexPath.row + 1) + ".jpg")
        let image = UIImage(contentsOfFile: fileURL.path)
        cell.imageView.image = image
        
        cell.frame.size = CGSize(width: 128, height: 50)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
}
