//
//  DateTime2.swift
//  0711
//
//  Created by woowabrothers on 2017. 7. 11..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation

class MyCalendar {
    let cal = NSCalendar.current
    var components = NSDateComponents()
    let dateFormatter = DateFormatter()
    
    func getNowDateTime() -> (year: Int,month: Int,day: Int,hour: Int,minute: Int,second: Int) {
        let component = cal.dateComponents([.year, .month, .day, .hour, .minute, .second], from: NSDate() as Date)
        return (component.year!, component.month!, component.day!, component.hour!, component.minute!, component.second!)
    }
    
    func getDateFormat(_ date_str: String) -> Date {
        dateFormatter.dateFormat = "yyyy/mm/dd"
        return dateFormatter.date(from: date_str)!
    }
    
    func getDateFormat(year: Int, month: Int, day: Int) -> Date {
        components.year = year
        components.month = month
        components.day = day
        
        return cal.date(from: components as DateComponents)!
    }
    
    //??어케
    func getKorDate(date: Date) -> String {
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .long
        
        return dateFormatter.string(from: date)
    }
    
    func getStartOfDate(year: Int, month: Int) -> String {
        let input_date = NSDateComponents()
        input_date.year = year
        input_date.month = month
        
        let getDate = cal.startOfDay(for: cal.date(from: input_date as DateComponents)!)
        let weekday = cal.component(.weekday, from: getDate)
        
        //dateformat = "EEEE"
        switch weekday {
        case 0: return "월요일"
        case 1: return "화요일"
        case 2: return "수요일"
        case 3: return "목요일"
        case 4: return "금요일"
        case 5: return "토요일"
        case 6: return "일요일"
        default: return "error"
        }
    }
    
    func printMonthCalendar(year: Int, month: Int) {
        var start_components = DateComponents(calendar: cal, year: year, month: month, day: 1)
        start_components.timeZone("GMT+9")
        
        let start_day = cal.date(from: start_components as DateComponents)
        print("start day : "+String(describing: start_day))
        let end_components = NSDateComponents()
        end_components.year = year
        end_components.month = month
        end_components.day = -1
        
        let end_day = cal.date(from: end_components as DateComponents)
        print("end day : "+String(describing: end_day))
        
       // let week = cal.dateComponents([.year, .month, .day], from: <#T##Date#>, to: <#T##Date#>)
    }
    
}

