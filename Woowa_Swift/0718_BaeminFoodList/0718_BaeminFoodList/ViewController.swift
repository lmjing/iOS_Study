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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let count = Food().typeList.count
        for index in 0..<count {
            let foodList = Food().getJsonArray(type: index)
            for food in foodList {
                downloadimage(imageName: food["detail_hash"] as! String, imageurl: food["image"] as! String)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Food().jsonSectionArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Food().getJsonArray(type: section).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let food = Food().getJsonArray(type: indexPath.section)[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        //cell.clearsContextBeforeDrawing = true
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
        
        //cell.imageView?.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        cell.imageView?.image = image
        print(cell.imageView?.image?.size.width)
        cell.imageView?.contentMode = UIViewContentMode.scaleAspectFit
//        cell.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let test = Bundle.main.loadNibNamed("HeaderTableViewCell", owner: self, options: nil)?.first as! HeaderTableViewCell
        return test.frame.height
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerString = Food().getHeaderDic(type: section)
        let test = Bundle.main.loadNibNamed("HeaderTableViewCell", owner: self, options: nil)?.first as! HeaderTableViewCell
        test.titleLabel.text = headerString.title
        test.descriptionLabel.text = headerString.description
        test.titleLabel.frame = CGRect(x: 0, y: 50, width: headerString.title.characters.count, height: 30)
        
        return test
    }
}

func downloadimage(imageName: String, imageurl: String) {
    print(imageName)
    let destination = getDestinationURL(imageName: imageName)
    let path = destination(URL(string: imageurl)!, HTTPURLResponse(url: URL(string: imageurl)!, mimeType: nil, expectedContentLength: 1, textEncodingName: nil))
    print(path)
        
    Alamofire.download(imageurl, to: destination).response { response in
        if response.error != nil {
            print(response.error!)
        }
    }
}

func getDestinationURL(imageName: String) -> DownloadRequest.DownloadFileDestination {
    let destination: DownloadRequest.DownloadFileDestination = { _, _ in
        let documentsURL = FileManager.default.urls(for: .cachesDirectory , in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent(imageName+".jpg")
        return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
    }
    return destination
}
