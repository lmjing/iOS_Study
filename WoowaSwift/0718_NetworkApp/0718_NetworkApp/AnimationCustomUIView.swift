//
//  AnimationCustomUIView.swift
//  0718_NetworkApp
//
//  Created by woowabrothers on 2017. 7. 18..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class AnimationCustomUIView: UIView {

    let jumpBtn: UIButton
//    let imageView: UIImageView
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    
    override init(frame: CGRect) {
        jumpBtn = UIButton(frame: CGRect(x: 0, y: 50, width: 200, height: 50))
        jumpBtn.backgroundColor = UIColor.yellow
        jumpBtn.titleLabel?.text = "JUMP"
//        imageView = UIImageView(image: #imageLiteral(resourceName: "hambuger.png"))
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        jumpBtn = UIButton(frame: CGRect(x: 0, y: 50, width: 200, height: 50))
        jumpBtn.backgroundColor = UIColor.yellow
        jumpBtn.titleLabel?.text = "JUMP"
//        imageView = UIImageView(image: #imageLiteral(resourceName: "hambuger.png"))
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
}
