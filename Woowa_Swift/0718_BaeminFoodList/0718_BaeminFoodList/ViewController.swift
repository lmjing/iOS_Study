//
//  ViewController.swift
//  0718_BaeminFoodList
//
//  Created by woowabrothers on 2017. 7. 18..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var foodAllList:[FoodSection] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataTask().getDetailData(hash: "HDF73", completionHandler:  { (complete: [String : Any]) in
            print(complete)
        })
        
        if DataTask().isConnectedToInternet() == true {
            view.layer.borderColor = UIColor(red: 173/255, green: 243/255, blue: 125/255, alpha: 1).cgColor
            view.layer.borderWidth = 2
        }else {
            view.layer.borderColor = UIColor(red: 255/255, green: 111/255, blue: 100/255, alpha: 1).cgColor
            view.layer.borderWidth = 2
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        foodAllList = FoodAllList.instance.allOfFoodList
        NotificationCenter.default.addObserver(self, selector: #selector(initData), name: NSNotification.Name("init"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initData(notification: Notification) {
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return foodAllList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodAllList[section].foodList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let food = (data[indexPath.section]?[indexPath.row])!
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
//        cell.titleLabel.text = food["title"] as? String
//        cell.descriptionLabel.text = food["description"] as? String
//        
//        //가격 설정
//        let sPrice = food["s_price"] as? String
//        let nPrice = food["n_price"] as? String
//        cell.makePriceLabel(salePrice: sPrice!, normalPrice: nPrice)
//        let badgeList = food["badge"] as? [String]
//        if badgeList != nil {
//            cell.makebadgeLabel(badge: badgeList!)
//        }
//        
//        //구: 이미지 다운 코드
////        let documentsURL = FileManager.default.urls(for: .cachesDirectory , in: .userDomainMask)[0]
////        let fileURL = documentsURL.appendingPathComponent(food["detail_hash"] as! String + ".jpg")
////        let image = UIImage(contentsOfFile: fileURL.path)
////        
////        cell.imageView?.image = image
////        cell.imageView?.contentMode = UIViewContentMode.scaleAspectFit
//        let url = URL(string: food["image"] as! String)!
//        cell.bgImgView.af_setImage(withURL: url)
        
        let food = foodAllList[indexPath.section].foodList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.titleLabel.text = food.title
        cell.descriptionLabel.text = food.description
        
        //가격 설정
        let sPrice = food.s_price
        let nPrice = food.n_price
        cell.makePriceLabel(salePrice: sPrice, normalPrice: nPrice)
        if food.badge != nil {
            cell.makebadgeLabel(badge: food.badge!)
        }
        
        let url = URL(string: food.image)!
        cell.bgImgView.af_setImage(withURL: url)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let test = Bundle.main.loadNibNamed("HeaderTableViewCell", owner: self, options: nil)?.first as! HeaderTableViewCell
        return test.frame.height
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerString = FoodList().getHeaderDic(type: section)
        let test = Bundle.main.loadNibNamed("HeaderTableViewCell", owner: self, options: nil)?.first as! HeaderTableViewCell
        test.titleLabel.text = headerString.title
        test.descriptionLabel.text = headerString.description
        test.titleLabel.frame = CGRect(x: 0, y: 50, width: headerString.title.characters.count, height: 30)
        
        return test
    }
}
