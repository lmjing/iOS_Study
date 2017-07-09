//4.3 연산자

import UIKit

//4.3.1 기본 연산자

/*
 1) 할당 연산자 : =
 어떠한 변수에 특정 값을 할당하거나 '변수 = 변수'형태로 변수의 값을 복사하는 용도로 사용할 수 있다.
 */
var intVal = 5
let intVal2 = 10
intVal = intVal2

/*
 2) 산술 연산자 : +, -, *, /
 사칙 연산을 표현, 문자열은 + 연산자를 이용해 붙일 수 있다.
 C의 산술 연산자와 다른 점 : 오버플로가 지원되지 않는다. but 고급 연산자 부분에서 설명할 오버플로 연산자를 이용해 오버플로를 반영할 수 있다.
 */
let intVal3 = intVal - 3
let stringVal = "Hello" + "String Variable"

/*
 3) 나머지 연산자 : %
 첫번째 피연산자를 두번째 피연산자로 나눈 나머지 값, 피연산자가 음수여도 상관없다.
 */
let modVal = 10 % 4
let modVal2 = 10 % -4

/*
 4) 단항 양수, 음수 연산자 : +, -
 단항 음수 연산자는 부호 변환 용도로 사용할 수 있지만, 단항 양수 연산자는 수치 계산에 아무런 영향을 주지 않는다.
 */
let intMinusVal = -intVal
let intPlusVal = +intMinusVal

/*
 5) 복합 할당 연산자 : +=, -=, *=, /=, %=
 */
var complexVal = 5
complexVal += 5
complexVal -= 3
complexVal *= 2
complexVal /= 7
complexVal %= 2

/*
 6) 비교 연산자 : ==, !=, >, <, >=, <=
 */
1 == 1
1 != 2
1 > 2
1 < 2
1 >= 2
1 <= 2

/*
 7) 범위 연산자 : a..<b (a<=x<b) , a...b (a<=x<=b)
 */
for index in 1...100 {
    print(index) // 1 ~ 100
}

for index in 1..<100 {
    print(index) // 1 ~ 99
}

/*
 8) 삼항 조건 연산자 : 조건식 ? 참일 경우의 값 : 거짓일 경우의 값
 if-else 한줄 버전
 */
var hasOther = true
var otherCount = hasOther ? 1 : 0
var intCount = intVal > 1 ? 1 : 0

/*
 9) Nil 결합 연산자 : a ?? b
 a와 b는 같은 타입, a는 옵셔널 변수
 옵셔널 변수인 a값을 확인, nil인 경우 b의 값을 반환하고 nil이 아닌 경우 a값을 반환
 */
let defaultSize = 100
var userSize: Int?
var currentSize = userSize ?? defaultSize
userSize = 3
var currentSize2 = userSize ?? defaultSize
//실험(a,b 순서 바꾸기) : 실행 되긴 하지만, 앞의 값을 확인하는 연산자다 보니 nil이 당연히 아니므로 앞의 값을 반환
var currentSize3 = defaultSize ?? userSize

/*
 10) 논리 연산자 : !, &&, ||
 */
let hasClothes = true
let hasSmall = true
var originalSize = 100
var usersize = 85

if (originalSize >= usersize) || (hasClothes && hasSmall) {
    print("There is your size")
}else {
    print("There isn't your size")
}

//4.3.2 고급 연산자

/*
 1) 비트 연산자 : ~, &, |, ^
 cf) 리터럴 2진 : 0b, 8진 :0o, 16잔 : 0x
 */
let initBits: UInt8 =   0b00101011
let secondBits: UInt8 = 0b10010111

let invertedBits = ~initBits // 0b11010100
let andBits = initBits & secondBits // 0b00000011
let orBits = initBits | secondBits // 0b10111111
let xorBits = initBits ^ secondBits // 0b10111100

/*
 2) 비트 시프트 연산자 : <<, >>
 */
let originalBits: UInt8 = 4 // 00000100
originalBits << 3 // 00100000 (3칸 이동)
originalBits >> 2 // 00000001 (2칸 이동)

/*
 3) 오버플로 연산자 : &+, &-, &*
 기존 연산자는 오버플로가 생기지 않도록 되어있음, 오버플로를 만들어야 하는 상황이라면 산술연산자 앞에 &을 입력해야 한다.
 */
var unsignedIntegerVal = UInt8.min
unsignedIntegerVal = unsignedIntegerVal &- 1

var unsigendIntegerVal2 = UInt8.max
unsigendIntegerVal2 = unsigendIntegerVal2 &+ 2

var unsigendIntegerVal3 = UInt8.max
unsigendIntegerVal3 = unsigendIntegerVal3 &* 2

//4.3.3 괄호 명시
/*
 어떤 연산자를 사용해 연산할 때 읽기가 복잡하거나 표현의 의도를 명확히 파악하기 쉽지 않을 때 사용
 if문에서 괄호를 사용하지 않아도 동작하지만, 괄호를 사용해도 무방
 */
let one = 1
let two = 2
if one > two {
    print("1: one > two")
}else {
    print("1: one < two")
}

if (one > two) {
    print("2: one > two")
}else {
    print("2: one < two")
}
