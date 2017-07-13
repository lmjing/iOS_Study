//
//  MyView.swift
//  0713_Draw
//
//  Created by woowabrothers on 2017. 7. 13..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class MyView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        let context = UIGraphicsGetCurrentContext()
        
        let colours = [UIColor.red.cgColor, UIColor.white.cgColor] as CFArray
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colours, locations: nil)
        context!.drawLinearGradient(gradient!, start: CGPoint(x: 0,y: 0), end: CGPoint(x: self.bounds.width, y: self.bounds.height), options: CGGradientDrawingOptions(rawValue: UInt32(0)))
        
        //UIColor.red.setFill()
//        UIRectFill(self.bounds)
    }

}
