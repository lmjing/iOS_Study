//
//  DateTime2.swift
//  0711
//
//  Created by woowabrothers on 2017. 7. 11..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation

class MyCalendar {
    let cal = Calendar.current
    var components = DateComponents()
    let dateFormatter = DateFormatter()
    let timeZone = TimeZone(secondsFromGMT: +9)
    
    func getNowDateTime() -> (year: Int,month: Int,day: Int,hour: Int,minute: Int,second: Int) {
        let component = cal.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date())
        return (component.year!, component.month!, component.day!, component.hour!, component.minute!, component.second!)
    }
    
    func getDateFormat(_ date_str: String) -> Date {
        dateFormatter.dateFormat = "yyyy/mm/dd"
        dateFormatter.timeZone = timeZone
        return dateFormatter.date(from: date_str)!
    }
    
    func getDateFormat(year: Int, month: Int, day: Int) -> Date {
        components = DateComponents(calendar: cal, timeZone: timeZone, year: year, month: month, day: day)

        return cal.date(from: components)!
    }
    
    func getKorDate(date: Date) -> String {
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .long
        
        return dateFormatter.string(from: date)
    }
    
    func getStartOfDate(year: Int, month: Int) -> String {
        let input_date = DateComponents(timeZone: timeZone, year: year, month: month)
        let startDate = cal.startOfDay(for: cal.date(from: input_date)!)
        /*
        let weekday = cal.component(.weekday, from: getDate)
        //이 함수는 한글만 되는 함수이므로 밑에 과정은 다른 함수를 따로 쓰는 것이 나을 듯
        switch weekday {
        case 2: return "월요일"
        case 3: return "화요일"
        case 4: return "수요일"
        case 5: return "목요일"
        case 6: return "금요일"
        case 7: return "토요일"
        case 1: return "일요일"
        default: return "error"
        }
        */
        dateFormatter.dateFormat = "EEEE"
        let weekday = dateFormatter.string(from: startDate)
       
        return weekday
    }
    
    func getMonthCalendar(year: Int, month: Int) -> [[Int]] {
        
        let end_date = DateComponents(calendar: cal, timeZone: timeZone, year: year, month: month+1, day: 0)
        let end_day = cal.component(.day, from: cal.date(from: end_date)!)
        
        var day = 0
        var result = [[Int]]()
        var week = [Int]()
        //let end_day = end_date.day ?? 0
        print(end_day)
        while day != end_day {
            day += 1

            let current_day = DateComponents(calendar: cal, timeZone: timeZone, year: year, month: month, day: day)
            let weekday = cal.component(.weekday, from: cal.date(from: current_day)!)
            week.append(current_day.day!)
            
            if weekday == 7 || day == end_day {
                result.append(week)
                week = [Int]()
            }
            
        }
        return result
    }
    
}

