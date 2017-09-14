////
////  DateTime.swift
////  0711
////
////  Created by woowabrothers on 2017. 7. 11..
////  Copyright © 2017년 woowabrothers. All rights reserved.
////
//
//import Foundation
//
//class MyCalendar {
//    
//    let calendar = NSCalendar.current
//    
//    func getNowDateTime() -> (year: Int,month: Int,day: Int,hour: Int,minute: Int,second: Int) {
//        let now = NSDate()
//        let calendar = NSCalendar.current
//        let component = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: now as Date)
//        return (component.year!, component.month!, component.day!, component.hour!, component.minute!, component.second!)
//    }
//    
//    //안됨
//    func getDateFormat(_ date_str: String) -> Date {
//        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy/mm/dd"
//        
//        let date = dateFormatter.date(from: date_str)
//        
//        return date!
//    }
//    
//    func getDateFormat(year: Int, month: Int, day: Int) -> Date {
//        let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
//        
//        let components = NSDateComponents()
//        components.year = year
//        components.month = month
//        components.day = day
//        
//        let date = calendar?.date(from: components as DateComponents)
//        return date!
//    }
//    
////    func getKorDateFormat(date: Date) -> String {
////        
////    }
//    
//    func getStartOfDate(year: Int, month: Int) {
//        let calendar = NSCalendar.current
//        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy/mm"
//        
//        let input_date = String(year)+"/"+String(month)
//        
//        let date = dateFormatter.date(from: input_date)
//        let start_date = calendar.startOfDay(for: date!)
//        
//        let components = calendar.dateComponents([.weekday], from: start_date)
//        
//        switch components.weekday! {
//        case 0: print("월")
//        case 1: print("화")
//        case 2: print("수")
//        case 3: print("목")
//        case 4: print("금")
//        case 5: print("토")
//        case 6: print("일")
//        default: print("error")
//        }
//    }
//}
