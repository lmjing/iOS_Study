//
//  DetailUIView.swift
//  0718_BaeminFoodList
//
//  Created by woowabrothers on 2017. 7. 20..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class DetailUIView: UIView {
    
    @IBOutlet weak var thumbnailImageView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var deliveryInfoLabel: UILabel!
    @IBOutlet weak var deliveryFeeLabel: UILabel!
    @IBOutlet weak var detailImageView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func draw(_ rect: CGRect) {
        thumbnailImageView.contentSize = CGSize(width: 1000, height: thumbnailImageView.frame.height)
    }
}
