//4.4 조건문과 반복문

import UIKit

//4.4.1 if문
var count = 10

//조건문을 괄호로 감쌀 필요는 없지만, else문 괄호 반드시 써주어야 함
if count >= 10 {
    print("count는 10보다 크거나 같다.")
}else {
    print("count은 10보다 작다")
}

//4.4.2 for문
for index in 1...100 {
    print("index is \(index)")
}

//4.4.3 switch문

/*
 fallthrough
 break 키워드를 사용하지 않아도 된다. (물론 사용해도 된다.)
 조건을 만족한다면 기본으로 다음 case를 실행하지 않게 된다.
 */
var color = "Red"

switch color {
case "Red":
    print("color is Red")
case "Yellow":
    print("color is Yellow")
case "Green":
    print("color is Green")
case "Blue":
    print("color is Blue"); break
default:
    print("what color?")
}

//4.4.4 while문
var integerVal = 10
var inRange = true

while inRange {
    print("A value is \(integerVal)")
    integerVal += 5
    
    if integerVal > 100 {
        inRange = false
    }
}

//repeat-while ( = do-while 문 )
integerVal = 10
inRange = true

repeat {
    print("A value is \(integerVal)")
    integerVal += 5
    
    if integerVal > 100 {
        inRange = false
    }
}while inRange