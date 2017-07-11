//
//  FileManager.swift
//  0711
//
//  Created by woowabrothers on 2017. 7. 11..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation

func getFiles() {
    do {
        let filemanager = FileManager.default
        let path = "/Library/Desktop Pictures"
        
        let files = try filemanager.contentsOfDirectory(atPath: path)
        let sub_files = try filemanager.subpathsOfDirectory(atPath: path)
        
        print("<" + path + ">")
        for file in files {
            print(file)
        }
        print("-----------")
        print("<" + path + " with sub Files>")
        for sub_file in sub_files {
            print(sub_file)
        }
    }catch {
        print("error")
    }
}
