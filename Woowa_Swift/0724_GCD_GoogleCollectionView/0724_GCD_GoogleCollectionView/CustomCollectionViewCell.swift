//
//  CustomCollectionViewCell.swift
//  0724_GCD_GoogleCollectionView
//
//  Created by woowabrothers on 2017. 7. 24..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
    }
    
    func configureCell(index: Int) {
        print(#function)
        DispatchQueue.main.async {
            let documentsURL = FileManager.default.urls(for: .cachesDirectory , in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(String(index + 1) + ".jpg")
            let image = UIImage(contentsOfFile: fileURL.path)
            self.imageView.image = image
        }
    }
    
    func configureCell2(image: UIImage) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
}
