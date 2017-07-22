//
//  DetailViewController2.swift
//  0718_BaeminFoodList
//
//  Created by 이미정 on 2017. 7. 22..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var detailView: DetailUIView!
    var detailFood: DetailFood? = nil
    var originalFood: Food? = nil
    var pageControl : UIPageControl = UIPageControl(frame: CGRect(x:50,y: 300, width:200, height:50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataTask().getDetailData(hash: (originalFood?.detail_hash)!, completionHandler:  { (complete: [String : Any]) in
            self.detailFood = DetailFood(originalFood: self.originalFood!, detailFood: complete)
            self.initView()
        })
    }
    
    func initView() {
        detailView.titleLabel.text = detailFood?.title
        detailView.descriptionLabel.text = detailFood?.description
        detailView.priceLabel.text = detailFood?.prices[0]
        detailView.pointLabel.text = detailFood?.point
        detailView.deliveryFeeLabel.text = detailFood?.delivery_fee
        detailView.deliveryInfoLabel.text = detailFood?.delivery_info
        
        configurePageControl()
        detailView.thumbnailImageView.delegate = self
        detailView.thumbnailImageView.isPagingEnabled = true
        setThumbImageView()
        pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControlEvents.valueChanged)
    }
    
    func setThumbImageView() {
        //썸네일 이미지 추가 ( controller에서 하는 것이 맞는가 )
        var imageXpoint = CGFloat(0)
        for img in (detailFood?.thumb_images)! {
            let imageView = UIImageView(frame: CGRect(x: imageXpoint, y: 0, width: view.frame.width, height: detailView.thumbnailImageView.frame.height))
            imageView.contentMode = .scaleAspectFit
            imageView.af_setImage(withURL: URL(string: img)!)
            detailView.thumbnailImageView.addSubview(imageView)
            imageXpoint += view.frame.width
        }
        detailView.thumbnailImageView.contentSize = CGSize(width: view.frame.width * CGFloat((detailFood?.thumb_images.count)!), height: detailView.thumbnailImageView.frame.height)
    }
    
    func configurePageControl() {
        self.pageControl.numberOfPages = (detailFood?.thumb_images.count)!
        self.pageControl.currentPage = 0
        self.view.addSubview(pageControl)
    }
    
    func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * view.frame.size.width
        detailView.thumbnailImageView.setContentOffset(CGPoint(x:x, y:0), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = detailView.thumbnailImageView.contentOffset.x / detailView.thumbnailImageView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }
}
