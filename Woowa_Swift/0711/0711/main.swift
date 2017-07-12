//
//  main.swift
//  0711
//
//  Created by woowabrothers on 2017. 7. 11..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//
import Foundation

//코딩미션1) 사람을 추상화하는 struct 만들기
//let mijeong = Intern(name: "mijeong lee", age: 24, phoneNumber: "010-4905-9020", email: "lmjing1234@gmail.com", gitID: "lmjing", part: .iOS, team: .Team4)
//dump(mijeong)
//
////코딩미션2) CGPoint를 활용한 사각형
//var rect1 = MyRect()
//print(rect1)
//dump(rect1)
//
//rect1.moveTo(delta: CGPoint(x: 2, y: 2))
//
//let rect2 = MyRect(origin: CGPoint(x: 0, y: 0), width: 3, height: 5)
//print(rect2)

//코딩미션3) 파일 가져오기
//getFiles()

let myCalendar = MyCalendar()
print(myCalendar.getNowDateTime())
print(myCalendar.getDateFormat("2013/01/10"))
print(myCalendar.getDateFormat(year: 2018, month: 03, day: 20))
print(myCalendar.getKorDate(date: Date()))
print(myCalendar.getStartOfDate(year: 2017, month: 2))
print(myCalendar.getMonthCalendar(year: 2017, month: 3))
//단위 변환
//print(lengthConverter(input: 20.0))
