//
//  CustomTableViewCell.swift
//  0718_BaeminFoodList
//
//  Created by woowabrothers on 2017. 7. 18..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var bgImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    var salePriceLabel = UILabel()
    var normalPriceLable = UILabel()
    var badgeLableList = [UILabel]()
    
    let labeStartXPoint = 131
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        descriptionLabel.font = UIFont(name: "Avenir", size: 13)
        descriptionLabel.textColor = UIColor.darkGray
        imageView?.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    }
    
    func makePriceLabel(salePrice: String, normalPrice: String?) {
        if normalPrice == nil {
            //가격이 하나만 있는 경우
            salePriceLabel = UILabel(frame: CGRect(x: labeStartXPoint, y: 65, width: 100, height: 25))
        }else {
            salePriceLabel = UILabel(frame: CGRect(x: labeStartXPoint+60, y: 65, width: 100, height: 25))
            normalPriceLable = UILabel(frame: CGRect(x: labeStartXPoint, y: 65, width: 60, height: 25))
            normalPriceLable.textColor = UIColor.lightGray
            
            let attributedText = NSMutableAttributedString(string: normalPrice!)
            attributedText.addAttributes([NSStrikethroughStyleAttributeName: 2], range: NSMakeRange(0, normalPrice!.characters.count))
            normalPriceLable.attributedText = attributedText
            
            contentView.addSubview(normalPriceLable)
        }
        salePriceLabel.textColor = UIColor.cyan
        salePriceLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        salePriceLabel.textColor = UIColor(red: 51/255, green: 192/255, blue: 186/255, alpha: 1)
        salePriceLabel.text = salePrice
        contentView.addSubview(salePriceLabel)
    }
    
    func makebadgeLabel(badge: [String]) {
        var beforeWidth = 0
        for temp in badge {
            let badgeLabel = UILabel(frame: CGRect(x: labeStartXPoint + beforeWidth, y: 95, width: temp.characters.count * 10 + 10, height: 20))
            badgeLabel.textColor = UIColor.white
            badgeLabel.font = UIFont(name: "Avenir", size: 12)
            badgeLabel.tag = labeStartXPoint
            badgeLabel.text = temp
            badgeLabel.textAlignment = .center
            switch temp {
            case "론칭특가", "이벤트특가":
                badgeLabel.backgroundColor = UIColor(red: 168/255, green: 118/255, blue: 189/255, alpha: 1)
            case "품절":
                badgeLabel.backgroundColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
            case "사은품증정":
                badgeLabel.backgroundColor = UIColor(red: 246/255, green: 180/255, blue: 42/255, alpha: 1)
            default:
                print("뱃지 default")
            }
            badgeLableList.append(badgeLabel)
            contentView.addSubview(badgeLabel)
            beforeWidth = temp.characters.count * 10 + 20
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        salePriceLabel.removeFromSuperview()
        normalPriceLable.removeFromSuperview()
        for view in badgeLableList { //take all subviews from your view
            view.removeFromSuperview() //delete it from you view
        }
    }
}
