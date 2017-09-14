//
//  Intern.swift
//  0711
//
//  Created by woowabrothers on 2017. 7. 11..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation

//코딩미션1) 사람을 추상화하는 struct 만들기
struct Intern {
    enum Programming{
        case iOS
        case Web
    }
    
    enum Team {
        case Team1
        case Team2
        case Team3
        case Team4
        case Team5
        case Team6
    }
    
    let name: String
    var age: Int
    var phoneNumber: String
    var email: String
    let gitID: String
    let part: Programming
    let team: Team
}
