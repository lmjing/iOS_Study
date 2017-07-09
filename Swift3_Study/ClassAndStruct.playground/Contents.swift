//4.6 클래스와 구조체

import UIKit

//4.6.1 클래스와 구조체의 생성

/*
 사용자 정의 타입, 프로퍼티를 사용해 여러가지 자료를 하나로 묶는 용도로 사용할 수 있다.
 또는, 내부에 어떤 처리를 할 수 있는 함수를 넣어 처리할 내용을 한꺼번에 묶는 용도로 사용하기도 한다.
 */
class BasicClass {
    
}

struct BaseStruct {
    
}

/*
 프로퍼티
 블록안에 선언, 초기화 하지 않은 상태에서 사용하려면 일반 변수 사용하고 초기화 한 후에 사용하려면 옵셔널 변수를 사용해도 무방
 */
class BasicClass2 {
    var sizeX = 0
    var sizeY = 0
}

struct BaseStruct2 {
    var title: String
    var writer: String
    var description: String?
}

//4.6.2 클래스 초기화 및 프로퍼티 사용

/*
 클래스는 참조
 클래스 초기화 : 내부의 초기화 함수 init 키워드 사용하여 초기화 함수 구현
 프로퍼티 사용 : 생성된 프로퍼티는 '인스턴스명.프로퍼티명'으로 사용 가능
 */
class BasicClass3 {
    var sizeX = 0
    var sizeY = 0
    
    func getArea() -> Int {
        return sizeX * sizeY
    }
    
    func printResult() {
        print("area : \(self.getArea())")
    }
    
    init(sizeX: Int, sizeY: Int) {
        self.sizeX = sizeX
        self.sizeY = sizeY
    }
}

var baseClass = BasicClass3(sizeX: 10, sizeY: 11)
print("Base's sizeX : \(baseClass.sizeX), sizeY : \(baseClass.sizeY)")
baseClass.printResult()

var baseClass2 = baseClass
baseClass2.sizeX = 20
print("Base's sizeX : \(baseClass.sizeX), Base2's sizeX : \(baseClass2.sizeX)") // base의 값도 변함

//4.6.3 구조체의 초기화 및 프로퍼티 사용

/*
 구조체는 복사
 구조체 초기화 : 내부의 초기화 함수 init 키워드 사용하여 초기화 함수 구현
 프로퍼티 사용 : 생성된 프로퍼티는 '인스턴스명.프로퍼티명'으로 사용 가능
 */
struct BaseStruct3 {
    var title: String
    var writer: String
    var description: String?
    
    init(title: String, writer: String) {
        self.title = title
        self.writer = writer
    }
    
    init(title: String, writer: String, description: String?) {
        self.title = title
        self.writer = writer
        self.description = description
    }
}

let baseStruct = BaseStruct3(title: "제목", writer: "Mijeong", description: "설명")
print("Base's title : \(baseStruct.title), writer : \(baseStruct.writer), description : \(baseStruct.description!)")

var baseStruct2 = baseStruct
baseStruct2.title = "제목2"
print("Base's title : \(baseStruct.title), Base2's title : \(baseStruct2.title)")


//4.6.4 클래스 상속

/*
 구조체는 상속 X, 클래스는 상속 O
 상속 : 상위 클래스의 메서드, 프로퍼티들을 모두 사용 가능
 오버라이딩 : 상위 클래스의 메서드, 프로퍼티 재정의
*/
class ChildClass : BasicClass3 {
    //프로퍼티 추가
    var sizeZ = 0
    
    //기존 프로퍼티 사용 가능 (재정의 처럼 되어 기존 init은 사용하지 못함)
    init(sizeX: Int, sizeY:Int, sizeZ:Int) {
        super.init(sizeX: sizeX, sizeY: sizeY)
        self.sizeZ = sizeZ
    }
    
    //새로운 함수 추가
    func getVolume() -> Int {
        return sizeX * sizeY * sizeZ
    }
    
    //기존 함수 오버라이딩
    override func printResult() {
        print("area : \(self.getArea()), volume : \(self.getVolume())")
    }
}

let child = ChildClass(sizeX: 10, sizeY: 10, sizeZ: 10)
child.printResult()
