//
//  HeaderTableViewCell.swift
//  0718_BaeminFoodList
//
//  Created by woowabrothers on 2017. 7. 18..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.layer.borderWidth = 2
        titleLabel.layer.borderColor = UIColor.lightGray.cgColor
        titleLabel.textColor = UIColor.lightGray
        titleLabel.frame = CGRect(x: 0, y: 10, width: titleLabel.frame.width + 20, height: titleLabel.frame.height + 8)
        titleLabel.center.x = contentView.center.x
        
        descriptionLabel.frame = CGRect(x: 0, y: 50, width: 100, height: 30)
        descriptionLabel.center.x = contentView.center.x
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
