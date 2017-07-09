//
//  datatype.swift
//  StudyiOS
//
//  Created by 이미정 on 2017. 7. 8..
//  Copyright © 2017년 이미정. All rights reserved.
//

import Foundation

class CCM: Music {
    var genre: String
    init(name: String, singer: String, genre: String) {
        self.genre = genre
        super.init(name: name, singer: singer)
    }
}

class POP: Music {
    var country: String
    init(name: String, singer: String, country: String) {
        self.country = country
        super.init(name: name, singer: singer)
    }
}

//palylist Type : 공통 상위 클래스인 Music[]
var playlist = [CCM(name: "청혼가", singer: "김명식", genre: "발라드"),
                POP(name: "봄날", singer: "방탄소년단", country: "Korea"),
                POP(name: "We don't talk anymore", singer: "Charlie Puth", country: "U.S.A")]

for instance in playlist {
    if let ccm = instance as? CCM {
        print("Title: '\(ccm.name) by '\(ccm.singer)', Gerne. '\(ccm.genre)'")
    } else if let pop = instance as? POP {
        print("Title: '\(pop.name) by '\(pop.singer)', Country. '\(pop.country)'")
    }
}
