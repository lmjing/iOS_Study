//
//  DetailViewController2.swift
//  0718_BaeminFoodList
//
//  Created by 이미정 on 2017. 7. 22..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class DetailViewController: UIViewController {
    
    @IBOutlet var detailView: DetailUIView!
    var detailFood: DetailFood? = nil
    var originalFood: Food? = nil
    var pageControl : UIPageControl = UIPageControl(frame: CGRect(x:50,y: 300, width:200, height:50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataTask = DataTask()
        dataTask.getDetailData(hash: (originalFood?.detail_hash)!, completionHandler:  { (complete: [String : Any]) in
            self.detailFood = DetailFood(originalFood: self.originalFood!, detailFood: complete)
            self.detailView.detailfood = self.detailFood
//            dataTask.downloadDetailImage(imageUrls: (self.detailFood?.detail_section)!, hash: (self.detailFood?.detail_hash)!)
        })
        
        NotificationCenter.default.addObserver(self, selector: #selector(setDetailImageView), name: NSNotification.Name("detailImage"), object: nil)
    }
    
//    func setDetailImageView(notification: Notification) {
//        print(notification.userInfo?["imageName"] as! String)
//        let image = DataTask.imageCache.image(withIdentifier: notification.userInfo?["imageName"] as! String)
//        
//        /*
//         * 이미지 하나당 height 계산법 
//         * x : y = a : b  -> b = y*a / x
//        */
//        let imageHeight = (view.frame.width * (image?.size.height)!) / (image?.size.width)!
//        
//        let imageView = UIImageView(frame: CGRect(x: 0, y: detailView.detailImageView.frame.height, width: view.frame.width, height: imageHeight))
//        imageView.image = image
//        detailView.detailImageView.addSubview(imageView)
//        
//        detailView.detailImageView.frame = CGRect(x: 0, y: 456, width: view.frame.width, height: detailView.detailImageView.frame.height + imageHeight)
//        
//        detailView.scrollView.contentSize = CGSize(width: view.frame.width, height: detailView.detailImageView.frame.height + 440 + detailView.orderButton.frame.height)
//    }

    func setDetailImageView(notification: Notification) {
        print("get noti")
        detailView.detailImageList = notification.userInfo?["detailImageDic"] as! [Int : String]
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
}
