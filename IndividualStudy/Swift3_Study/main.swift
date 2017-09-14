//
//  main.swift
//  StudyiOS
//
//  Created by 이미정 on 2017. 7. 8..
//  Copyright © 2017년 이미정. All rights reserved.
//

import Foundation

print("Hello, Swift!")

class Music {
    var name: String
    var singer: String
    init(name: String, singer: String) {
        //this 대신 self 사용
        self.name = name
        self.singer = singer
    }
}
