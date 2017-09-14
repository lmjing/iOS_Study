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
        cell.bgImageView.af_setImage(withURL: url)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let test = Bundle.main.loadNibNamed("HeaderTableViewCell", owner: self, options: nil)?.first as! HeaderTableViewCell
        return test.frame.height
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let test = Bundle.main.loadNibNamed("HeaderTableViewCell", owner: self, options: nil)?.first as! HeaderTableViewCell
        
        guard let sectionInfo = foodAllList[section].foodType.section else { return test }
        test.titleLabel.text = sectionInfo.title
        test.descriptionLabel.text = sectionInfo.description
        test.titleLabel.layer.frame = CGRect(x: 0, y: 10, width: sectionInfo.title.characters.count, height: 30)
        
        return test
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let food = foodAllList[indexPath.section].foodList[indexPath.row]
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "detailVC") as! DetailViewController;
        vc.originalFood = food
        navigationController?.pushViewController(vc, animated: true)
    }
}
