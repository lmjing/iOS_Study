//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/*
 *closure 사용
 */
let couponVATClosure = { (source: Double) -> Double in
    return source * 0.9
}

/*
 *closure의 축약
 */
let addVATClosure = { (source: Double) -> Double in
    return source * 1.1
}
// 자료형 생략, 추론 가능
let addVATClosure2 = { source in return source * 1.1 }
// return 생략
let addVATClosure3 = { source in source * 1.1 }
// 매개변수 생략(대신 위치로 접근)
let addVATClosure4 = { $0 * 1.1 }

// 모두 동일한 결과 값
let price1 = addVATClosure(157.6)
let price2 = addVATClosure2(157.6)
let price3 = addVATClosure3(157.6)
let price4 = addVATClosure4(157.6)

/*
 * 함수를 리턴하는 함수(Currying)
 */
//기본형
func makeAdder (_ x:Int) -> (Int) -> Int {
    func adder (a:Int) -> Int {
        return x + a
    }
    return adder
}
//클로저 적용..?
func makeAdder2 (_ x:Int) -> (Int) -> Int {
    let adder: (Int) -> Int = {
        return $0 + x
    }
    return adder
}
//함축형?
func makeAdder3 (_ x:Int) -> (Int) -> Int {
    return {
        return $0 + x
    }
}

//선언
let add5 = makeAdder(5)
let add10 = makeAdder2(10)

print(add5(2))
print(add10(2))
print(makeAdder3(20)(2))



/*
 * map - 반복문 대체
 */

let transactions = [560.0, 321.5, 190.0, 678.2, 110.0, 450.0]

//for문으로 돌렸을 때
func addVAT(source:Double) -> Double {
    return source * 1.1
}

var vatPrices:[Double] = []

for transaction in transactions {
    vatPrices += [addVAT(source: transaction)]
}

//map & 클로저 함수 이용
let VATMapPrices = transactions.map({ transaction -> Double in
    return transaction * 1.1
})
//map & 클로저 함축형 ( 결과가 같다 했는데 왜 그래프..? )
let VATMapPrices2 = transactions.map({ $0 * 1.1 })


/*
 * filter - 조건문 대체
 */

//배열 -> for - if문으로 돌릴 때
var bigTransactions:[Double] = []

for price in vatPrices{
    if price >= 500{
        bigTransactions += [price]
    }
}
//배열 -> filter함수 적용할 때
var bigFilterTransactions = vatPrices.filter { $0 >= 500 }
print(bigFilterTransactions)

//딕셔너리 -> filter 함수 적용할 때
let family:[String:Int] = ["Dad":54, "Mom":50, "Mijeong":24, "Inhwan":20]

let age = 30
let young = family.filter({ $0.1 < age })
//결과 값 : 튜플 형태 -> 즉, 키 값으로 접근 불가능.
print(young)
print(young[0])
//print(young["Mijeong"])


/*
 * sorted(by : ) - 정렬
 */
// 배열
//함수 따로 선언 해주는 방법
func ascendantSort (sort1:Double, sort2:Double) -> Bool {
    return sort1 > sort2
}

let sortedPrices = vatPrices.sorted(by: ascendantSort)
//클로저 사용
let sortedPrices2 = vatPrices.sorted(by: {sort1, sort2 in return sort1 > sort2})
print(sortedPrices2)
//클로저 함축형 사용
let sortedPrices3 = vatPrices.sorted(by: { $0 > $1 })
print(sortedPrices3)
//완전 함축형 - 부등호만 선언
let sortedPrices4 = vatPrices.sorted(by: >)

//딕서녀리 - sorted 사용 정렬
let sortedFamily = family.sorted(by: { $0.1<$1.1 })
print(sortedFamily)


/*
 * reduce - 컬렉션의 항목들을 조건에 따라 하나의 값으로 만든다.
 */

//배열
func priceSum (base:Double, adder:Double) -> Double {
    return base + adder
}
//기존 for문을 이용해 합치는 방법
var sum:Double = 0.0
for price in vatPrices{
    sum = priceSum(base: sum, adder: price)
}

//reduce & 함수 이용(처음 파라매터는 초기 값이다.)
var sum2 = 0.0
let sumeReduce = vatPrices.reduce(sum2, priceSum)
//reduce & 클로저 이용
let sumReduce2 = vatPrices.reduce(0.0, { base, adder in
    base + adder
})
//reduce & 연산자 이용
let sumReduce3 = vatPrices.reduce(0.0, +)
//reduce 이용 하나의 문자열 만들기
let pricesInString = vatPrices.reduce("", { $0 + "\($1)\n"})
print(pricesInString)

//딕셔너리 - 합쳐서 하나의 문장 만들기
let WeAreFamily = family.reduce("I have a Family : \n", { $0 + "\($1.0)'s age is \($1.1)\n"})
print(WeAreFamily)

import Foundation

func lengthConverter(input: Double) -> Measurement<UnitLength> {
    let original = Measurement(value: input, unit: UnitLength.meters)
    
    let converted = original.converted(to: UnitLength.centimeters)
    return converted
}

print(lengthConverter(input: 20.0).description)


//: Playground - noun: a place where people can play

import UIKit
import Foundation

var str = "Hello, playground"

//다른걸 기대하는 경우가 있으므로 operator 띄어쓰기 해줘야 한다.
1 + 2
12 - 34
5 * 6
78 / 9
10 % 3

var 한글 = "한글"
print(한글)

//예제1) 두 점 사이의 거리를 실수로 계산하는 함수
func distance(ax: Int, ay: Int, bx: Int, by: Int) -> Float {
    let x_difference = ax - bx
    let y_difference = ay - by
    
    let result: Float = pow(Float(x_difference),2) + pow(Float(y_difference),2)
    //let result2 = (x_difference * x_difference) + ( y_difference * y_difference )
    
    return result.squareRoot()
}

print(distance(ax: 3, ay: 4, bx: 0, by: 0))
print(distance(ax: 1, ay: 1, bx: 5, by: 6))

//예제2) 예제1을 튜플로 받아라
typealias Point = (x: Int,y: Int)
func distance2(a: Point, b: Point) -> Double {
    let x_difference = a.x - b.x
    let y_difference = a.y - b.y
    
    let result = pow(Double(x_difference),2) + pow(Double(y_difference), 2)
    
    return result.squareRoot()
}

print(distance2(a: (1,1), b: (5,6)))
let a_point: Point = (3,4)
let b_point = (0,0)
print(distance2(a: a_point, b: b_point))

//예제3) 문자열 년도월일을 입력받아 만 나이 구하기
func age(_ from: String) -> Int {
    let now = NSDate()
    print(now)
    
    //let now_year = Int(now.substring(to: now.index(now.startIndex, offsetBy: ))
    
    var age: Int = 0
    
    let end_index = from.index(from.startIndex, offsetBy: 2)
    var year = Int(from.substring(to: end_index))
    if year != nil {
        year! += 1900
        age = 2017 - year!
    }
    
    let str_index = from.index(from.startIndex, offsetBy: 2)
    let birth = Int(from.substring(from: str_index))
    
    if birth != nil {
        if birth! > 0710 {
            age -= 1
        }
    }
    
    return age
}

age("940529")

/*
 예제4)
 리스트의 원소 값은 다음 리스트의 위치를 가르킨다.
 원소의 값이 음수가 나오면 행동을 멈춘다.
 */

//전체 리스트를 탐방하며 프린트 하기
func enumerateList(_ A: [Int]) {
    var index = 0
    while index >= 0 {
        print(A[index])
        index = A[index]
    }
}
enumerateList([1,4,-1,3,2])
enumerateList([5,4,3,-1,2,1])

//위의 원칙대로 실행했을 경우 완성되는 리스트의 길이 출력하기
func countOfList(_ A: [Int]) -> Int {
    var count = 0
    var index = 0
    while index >= 0 {
        index = A[index]
        count += 1
    }
    return count
}
print(countOfList([1,4,-1,3,2]))
print(countOfList([5,4,3,-1,2,1]))

//위의 원칙대로 실행했을 경우 입력 배열의 모든 원소를 확인하는 경우 true, 하나라도 없는 경우 false
func isFullList(_ A: [Int]) -> Bool {
    var result = true
    if A.count > countOfList(A) {
        result = false
    }
    return result
}
print(isFullList([1,4,-1,3,2]))
print(isFullList([5,4,3,-1,2,1]))

//예제5) 입력 받은 Array중 2,3의 배수를 골라서 골라진 수에 각 5씩 곱한 후 모든 합산 값을 리턴하라.
func complex(from array: [Int]) -> Int {
    return array.filter({ $0 % 2 == 0 || $0 % 3 == 0 }).map({ $0 * 5 }).reduce(0, { $0 + $1 })
}
print(complex(from: [1,2,3]))
print(complex(from: [1,2,3,6]))
