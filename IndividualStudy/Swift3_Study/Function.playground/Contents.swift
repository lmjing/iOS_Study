//4.5 함수

import UIKit

/*
 1) 기본 형태
 func 함수이름(파라미터 이름: 데이터 타입, [파라미터 이름: 데이터 타입,]) -> 반환 값 데이터 타입 {
    코드 블록
 }
 */
//greetingMsg( name : String ) 반환 String 내용 "Hello, name" 반환 그다음에 프린트 하기
func greetingMsg(name: String) -> String {
    return "Hello, \(name)"
}

print(greetingMsg(name: "Mijeong Lee"))

/*
 2) 가변형 파라미터인 함수
 파라미터 타입 뒤에 '...'을 붙이면 가변형으로 인식함
 내부 구문에서 가변형 인 것으로 가정하고 처리하면 됨
 */
func greetingMsg2(names: String...) -> String {
    var msg = "Hello"
    
    for name in names {
        msg += ", \(name)"
    }
    return msg
}

print(greetingMsg2(names: "Mijeong","Inhwan","Yoonju","Byeongdae"))

/*
 3) 반환 값이 없는 경우의 함수
 단순히 반환 값 명시하지 않으면 됨
 */
func greetingMsg3(names: String...) {
    var msg = "Hello"
    
    for name in names {
        msg += ", \(name)"
    }
    print(msg)
}

greetingMsg3(names: "Mijeong")

/*
 4) 반환 값이 여러개인 경우
 모든 반환 값 타입과 이름을 명시해주어야만 사용 가능
 */
func greetingMsg4(name: String) -> (morning: String, afternoon: String, evening: String) {
    let morningMsg = "good morning, \(name)"
    let afternoonMsg = "good afternoon, \(name)"
    let eveningMsg = "good evening, \(name)"
    
    return (morning: morningMsg, afternoonMsg, eveningMsg)
}

print(greetingMsg4(name: "Mijeong").morning)
