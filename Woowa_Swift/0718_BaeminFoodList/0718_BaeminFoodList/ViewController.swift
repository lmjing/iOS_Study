//
//  ViewController.swift
//  0718_BaeminFoodList
//
//  Created by woowabrothers on 2017. 7. 18..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Food().jsonSectionArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Food().getJsonArray(type: section).count
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return section.description
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let foodList = Food().getJsonArray(type: indexPath.section)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        //cell.clearsContextBeforeDrawing = true
        cell.titleLabel.text = foodList[indexPath.row]["title"] as? String
        cell.descriptionLabel.text = foodList[indexPath.row]["description"] as? String
        
        //가격 설정
        let sPrice = foodList[indexPath.row]["s_price"] as? String
        let nPrice = foodList[indexPath.row]["n_price"] as? String
        cell.makePriceLabel(salePrice: sPrice!, normalPrice: nPrice)
        let badgeList = foodList[indexPath.row]["badge"] as? [String]
        if badgeList != nil {
            cell.makebadgeLabel(badge: badgeList!)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        let header = Bundle.main.loadNibNamed("CustomTableViewCell", owner: self, options: nil)?.first as! CustomTableViewCell
        return 84.5
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let test = Bundle.main.loadNibNamed("HeaderTableViewCell", owner: self, options: nil)?.first as! HeaderTableViewCell
        test.textLabel?.text = "test"
        print(test)
        return test
    }
}
