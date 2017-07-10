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