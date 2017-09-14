//
//  main.swift
//  0717_ExtensionString
//
//  Created by woowabrothers on 2017. 7. 17..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation

print("Hello, World!")

//extension String {
//    func filterHangulWord(input: String) -> Array<String> {
//        return result
//    }
//}

var nameArray = [
    [ "ᄀ": ["김다인", "김수완", "김준영", "김하은", "김형종"] ],
    [ "ᄇ": ["박예준", "박진수"]],
    [ "ᄉ": ["서동욱", "송통일"]],
    [ "ᄋ": ["양재형", "오세훈", "이단비", "이미정", "이정웅", "이준범"]],
    [ "ᄌ": ["전한나"]],
    [ "ᄎ": ["최송이", "최혜선"]],
    [ "ᄒ": ["한민호", "한지웅", "홍성호", "홍창남", "황예린"]]]

let section = 4
let row = 0

let key = nameArray[section].keys.first!
nameArray[section][key]?.remove(at: row)
if nameArray[section][key]?.count == 0 {
    nameArray.remove(at: section)
}

print(nameArray,"asdf")
