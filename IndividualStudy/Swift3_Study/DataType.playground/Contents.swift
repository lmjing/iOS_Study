//: Playground - noun: a place where people can play

import UIKit

//1. 코드 작성
//compile is "command+B"

//세미콜론은 한 줄에 여러 문장을 작성할 때 사용
var str2 = "One line"; print(str2)

//파운데이션 프레임워크 import
import Foundation;

//콤마를 사용해 다수의 데이터 함께 작성 가능
print("Hello","World")

/* This is iOS 4.2 */

//4.2.1 상수와 변수

/*
 자동으로 초기화 되지 않으니 직접 초기화 해야한다.
 
 var 변수 - 어떠한 자료(데이터)를 제공하는 공간, 혹은 그 공간의 이동
 let 상수 - 어떠한 자료(데이터)를 제공하는 공간, 혹은 그 공간의 이동 - 상수는 한번 값을 지정하면 변경 불가능
 */

let name = "Mijeong", age = 24
//name = "leemijeong"
var nickname = "Jake"
print(name+"'s nickname is "+nickname)
nickname = "lmjing"
print(name+"'s nickname is "+nickname)

//4.2.2 기본 데이터 타입
var integerVar: Int = 10
let floatVar: Float = 44.195
//선언과 초기화 분리화
var doubleVar: Double
doubleVar = 11.313
//형변환
let intVar = Int(doubleVar)
let floatVar2: Float = Float(intVar)
print(floatVar2+floatVar)

//4.2.3 문자와 문자열 다루기
let woman = "Jane"
let man = "James"
let title = woman+" & "+man
let title2 = "\(man) & \(woman)"

print(title)
print(title2)

//4.2.4 유니코드 표현 ( 16진수 )
let dollarSign = "\u{24}"
let blackheart = "\u{2665}"
let sparklingHeart = "\u{1F496}"
let sparklingHeart2 = "\u{0001F496}"

//4.2.5 타입 세이프와 타입 추정
/*
 타입 세이프 : 컴파일러가 어떤 변수의 타입인지를 항상 알 수 있다는 것
 타입 추정 : 변수(or 상수)가 정의되고 초기화될 때 혹은 값을 할당할 때 할당되는 값을 보고 해당 변수의 타입을 알아서 지정하는 것
 Swift는 타입 추정을 사용한다. 이를 기반으로 타입 세이프한 언어라고 말할 수 있다.
 */
let isItString = "This is String"
let isItInt = 12

//4.2.6 타입 변환
/*
 Swift는 타입세이프한 언어이므로 타인 변환을 통해 인스턴스의 타입을 확인하는 과정이 반드시 필요
 
 타입 변환 방법
 1. is, as 같은 키워드를 통해 확인
 2. 2개의 값을 비교하는 과정을 통해 타입을 확인
 */
class Music {
    var name: String
    var singer: String
    init(name: String, singer: String) {
        //this 대신 self 사용
        self.name = name
        self.singer = singer
    }
}

class CCM: Music {
    var genre: String
    init(name: String, singer: String, genre: String) {
        self.genre = genre
        super.init(name: name, singer: singer)
    }
}

class POP: Music {
    var country: String
    init(name: String, singer: String, country: String) {
        self.country = country
        super.init(name: name, singer: singer)
    }
}

//palylist Type : 공통 상위 클래스인 Music[]
var playlist = [CCM(name: "청혼가", singer: "김명식", genre: "발라드"),
                POP(name: "봄날", singer: "방탄소년단", country: "Korea"),
                POP(name: "We don't talk anymore", singer: "Charlie Puth", country: "U.S.A")]

//Downcasting Test
for instance in playlist {
    //is,as : 원래 Music 클래스 타입으로 인식되는 인스턴스들을 다운캐스팅해서 CCM or POP 인스턴스인지 판별함
    if instance is CCM{
        print("'\(instance.name)' is CCM")
    }
    /* 
        아래 코드에 is 사용 불가
        let p = instance is POP 이런식으로 새로운 상수,변수 선언이 불가했음
        instance는 곧 Music이므로 country에 접근 불가
    */
    if let ccm = instance as? CCM {
        print("Title: '\(ccm.name) by '\(ccm.singer)', Gerne. '\(ccm.genre)'")
    } else if let pop = instance as? POP {
        print("Title: '\(pop.name) by '\(pop.singer)', Country. '\(pop.country)'")
    }
}

//4.2.7 중첩 타입
/*
 열거형(enum), 클래스(class), 구조체(struct) 등 사용자 정의 타입 안에 또 다른 사용자 정의 타입을 정의 할 수 있음
 아래는 중첩 타입이 적용된 블랙잭 코드로 struct 안에 enum,struct이 재정의 된 것을 확인 가능
 */
//rawvaule : 열거형의 원시 값
struct BlackjackCard{
    enum Suit: Character {
        case Spades = "♠︎", Hearts = "♡", Diamonds = "♢", Clubs = "♣︎"
    }
    
    enum Rank: Int {
        case Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten
        case Jack, Queen, King, Ace
    
        struct Values {
            let first: Int, second: Int?
        }
    
        //열거값임을 표현하기 위해 .을 찍어줌
        var values: Values {
            switch self {
            case .Ace:
                return Values(first: 1, second: 11)
            case .Jack, .Queen, .King:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue),"
        output += " value is \(rank.values.first)"
        
        if let second = rank.values.second {
            output += " or \(second)"
        }
        
        return output
    }
}

let theAceOfSpades = BlackjackCard(rank: .Ace, suit: .Spades)
print("theAceOfSpades: \(theAceOfSpades.description)")

let heartsSymbol = BlackjackCard.Suit.Hearts.rawValue

//4.2.8 옵셔널
/*
 ? 사용, 어떤 변수의 값에 nil이 들어갈 수 있다고 표현하는 것
 */
var hasntNil: Int = 0
var hasNil: Int? = nil

/*
 Forced Unwrapping : 옵셔널 변수의 값을 강제로 꺼내오는 형태
 ! 사용, 옵셔널 변수에 값이 확실히 있다는 것을 알 수 있으며 이를 사용하겠다는 의미를 컴파일러에게 알려주게 됨
 만약 값이 nil인 경우 런타임 에러가 발생할 수 있으므로, 해당 기능을 사용하기 전 꼭 값이 있는지 확인하는 루틴 코드가 필요
 */
if hasNil != nil {
    print("This variable has an value of \(hasNil!)")
}