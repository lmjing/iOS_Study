//
//  MyRect.swift
//  0711
//
//  Created by woowabrothers on 2017. 7. 11..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation

struct MyRect {
    var pointA: CGPoint
    var pointB: CGPoint
    var pointC: CGPoint
    var pointD: CGPoint
    
    init() {
        pointA = CGPoint(x: 0, y: 0)
        pointB = CGPoint(x: 0, y: 0)
        pointC = CGPoint(x: 0, y: 0)
        pointD = CGPoint(x: 0, y: 0)
    }
    
    init(origin: CGPoint, width: Double, height: Double) {
        pointA = origin
        pointB = CGPoint(x: Double(origin.x), y: Double(origin.y)+height)
        pointC = CGPoint(x: Double(origin.x)+width, y: Double(origin.y)+height)
        pointD = CGPoint(x: Double(origin.x)+width, y: Double(origin.y))
    }
    
    //mutating : 속성을 수정가능 하도록 해주는 키워드
    mutating func moveTo(delta: CGPoint) {
        pointA = CGPoint(x: pointA.x + delta.x, y: pointA.y + delta.y)
        pointB = CGPoint(x: pointB.x + delta.x, y: pointB.y + delta.y)
        pointC = CGPoint(x: pointC.x + delta.x, y: pointC.y + delta.y)
        pointD = CGPoint(x: pointD.x + delta.x, y: pointD.y + delta.y)
    }
    
}
