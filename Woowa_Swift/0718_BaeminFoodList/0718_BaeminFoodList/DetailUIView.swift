//
//  DetailUIView.swift
//  0718_BaeminFoodList
//
//  Created by woowabrothers on 2017. 7. 20..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class DetailUIView: UIView, UIScrollViewDelegate {
    
    @IBOutlet weak var thumbnailImageView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var deliveryInfoLabel: UILabel!
    @IBOutlet weak var deliveryFeeLabel: UILabel!
    @IBOutlet weak var detailImageView: UIView!
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var deliveryFeeTitleLabel: UILabel!
    
    var pageControl : UIPageControl = UIPageControl(frame: CGRect(x:50,y: 300, width:200, height:50))
    
    var detailfood: DetailFood? {
        didSet {
            if let detailFood = detailfood {
                titleLabel.text = detailFood.title
                descriptionLabel.text = detailFood.description
                //TODO : 가격 어떤거 띄워줘야 함?
                priceLabel.text = detailFood.prices[0]
                pointLabel.text = detailFood.point
                deliveryInfoLabel.text = detailFood.delivery_info
                deliveryInfoLabel.numberOfLines = 3
                deliveryInfoLabel.sizeToFit()
                
                let offsetY = deliveryInfoLabel.frame.height + deliveryFeeTitleLabel.frame.minY
                deliveryFeeTitleLabel.frame = CGRect(x: 17, y: offsetY, width: 64, height: 21)
                deliveryFeeLabel.frame = CGRect(x: 99, y: offsetY, width: 255, height: 21)
                deliveryFeeLabel.text = detailFood.delivery_fee
                
                configurePageControl()
                thumbnailImageView.delegate = self
                thumbnailImageView.isPagingEnabled = true
                setThumbImageView()
                pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControlEvents.valueChanged)
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
    }
    
    func setThumbImageView() {
        var imageXpoint = CGFloat(0)
        for img in detailfood!.thumb_images {
            let imageView = UIImageView(frame: CGRect(x: imageXpoint, y: 0, width: frame.width, height: thumbnailImageView.frame.height))
            imageView.contentMode = .scaleAspectFit
            imageView.af_setImage(withURL: URL(string: img)!)
            thumbnailImageView.addSubview(imageView)
            imageXpoint += frame.width
        }
        thumbnailImageView.contentSize = CGSize(width: frame.width * CGFloat(detailfood!.thumb_images.count), height: thumbnailImageView.frame.height)
    }
    
    func configurePageControl() {
        self.pageControl.numberOfPages = detailfood!.thumb_images.count
        self.pageControl.currentPage = 0
        self.addSubview(pageControl)
    }
    
    func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * frame.size.width
        thumbnailImageView.setContentOffset(CGPoint(x:x, y:0), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = thumbnailImageView.contentOffset.x / thumbnailImageView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }
    
    var detailImageList: [Int : String]? {
        didSet {
            for (_, name) in detailImageList! {
                print(name)
                setDetailImageView(imageName: name)
            }
            scrollView.contentSize = CGSize(width: frame.width, height: detailImageView.frame.height + 440 + orderButton.frame.height)
        }
    }
    
    func setDetailImageView(imageName: String) {
        let image = DataTask.imageCache.image(withIdentifier: imageName)!
        /*
         * 이미지 하나당 height 계산법
         * x : y = a : b  -> b = y*a / x
         */
        let imageHeight = (frame.width * image.size.height) / image.size.width
        let imageView = UIImageView(frame: CGRect(x: 0, y: detailImageView.frame.height, width: frame.width, height: imageHeight))
        imageView.image = image
        detailImageView.addSubview(imageView)
        let offsetY = deliveryFeeTitleLabel.frame.height + deliveryFeeTitleLabel.frame.midY
        detailImageView.frame = CGRect(x: 0, y: offsetY, width: frame.width, height: detailImageView.frame.height + imageHeight)
    }
}
