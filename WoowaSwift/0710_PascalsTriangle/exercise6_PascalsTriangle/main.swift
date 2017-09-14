//
//  main.swift
//  exercise6_PascalsTriangle
//
//  Created by woowabrothers on 2017. 7. 10..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation

func makePascalTriangle(numOfRows : Int) -> ([[Int]]) {
    var list = [[Int]]()
    var index = 0

    while index < numOfRows {
        list.append([1])
    
        switch index {
        case 0: break
        case 1:
            list[1].append(1)
        default:
            list[index] = MakeSumOfList(before_list: list[index-1])
        }
        
        index += 1
    }
    return list
}

func MakeSumOfList(before_list: [Int]) -> [Int] {
    var result: [Int] = [1]
    for index in 0..<before_list.count-1 {
        result.append(before_list[index]+before_list[index+1])
    }
    result.append(1)
    return result
}

func makePascalTriangle2(numOfRows : Int) -> ([[Int]]) {
    let init_array = [[1]]
    
    for index in 1..<numOfRows {
        makeLow(array: init_array, index: index)
    }
}

func makeLow(array: [[Int]],index: Int) {
    let nextList = zip([0]+array[index-1],array[index-1]+[0]).map({$0.0 + $0.1})
    let mergedList = zip(array, [nextList])
}

for arg in CommandLine.arguments {
    if let size = Int(arg) {
        let result = makePascalTriangle(numOfRows: size)
        //make triangle
        print("[")
        for index in 0..<result.count {
            if(index == result.count-1) {
                print(result[index])
            }else {
                var blank: String = ""
                for i in 0...result.count-index {
                    blank += " "
                }
                print(blank, terminator: "")
                print(result[index], terminator: ",\n")
            }
        }
        print("]")
        
        //print simple
//        for list in makePascalTriangle(numOfRows: size) {
//            print(list)
//        }
    }else {
        print("Please put Integer")
    }
}

