//
//  main.swift
//  test2
//
//  Created by woowabrothers on 2017. 8. 30..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation

print("Hello, World!")

let k = ["c" : 1.7, "b" : 0.08, "a" : 1.4]
let test = [[]]

k.flatMap({$0}).sorted { $0.0.0 < $0.1.0 }.map({a,b in print(a)})
