//
//  ViewController.swift
//  0718_BaeminFoodList
//
//  Created by woowabrothers on 2017. 7. 18..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var data = [Int : [[String:Any]]]()
    var section = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        FoodList.instance.getDataFromURL()
        NotificationCenter.default.addObserver(self, selector: #selector(initData), name: NSNotification.Name("init"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initData(notification: Notification) {
        let result = notification.userInfo?["result"] as! [[String:Any]]
        data[section] = result
        section += 1
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        print(data.count)
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return data[section]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        let food = (data[indexPath.section]?[indexPath.row])!
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.titleLabel.text = food["title"] as? String
        cell.descriptionLabel.text = food["description"] as? String
        
        //가격 설정
        let sPrice = food["s_price"] as? String
        let nPrice = food["n_price"] as? String
        cell.makePriceLabel(salePrice: sPrice!, normalPrice: nPrice)
        let badgeList = food["badge"] as? [String]
        if badgeList != nil {
            cell.makebadgeLabel(badge: badgeList!)
        }
        
        let documentsURL = FileManager.default.urls(for: .cachesDirectory , in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent(food["detail_hash"] as! String + ".jpg")
        let image = UIImage(contentsOfFile: fileURL.path)
        
        cell.imageView?.image = image
        cell.imageView?.contentMode = UIViewContentMode.scaleAspectFit
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
