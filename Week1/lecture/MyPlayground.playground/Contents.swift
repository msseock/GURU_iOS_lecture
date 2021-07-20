// 변수를 왜 사용하느냐? 뭔가 저장해두기 이해서 저장해뒀다가 다음에 다시 쓰려고
var greeting = "Hello, playground"
let greeting2 = "Hello SWU"

var greeting3:String = "" // 명시적 타입 지정(선호)
var number1:Int = 333
var number2:Double = 3.14
// NS <- NextStep

// 연산
3 + 7
3 - 7
3 * 7
3 / 7
number1 + 7
3 - number1
number1 * number1

print("\(number1) \(greeting) \(number2)")

/*
 입력 : 키보드, 음성, 터치
 저장 : 변수
 처리 : 사칙연산, 문자열연산, 판별, 반복, 함수
 출력 : 화면에 출력, 소리
 
 문법요소들을 알고있어야 한다.
 */

// if문!!
// if문은 총 3가지의 키워드로 구성된다
// if, else if , else
// 하나의 if문을 구성할 때
/*
 if : 무조건 딱 1번 등장
 else if : 없거나 여러번
 else : 없거나 딱 1번
 */
if number1 > 100 {
    
} else if (false) {
    
} else {
    
}

// 조건식 : 명제 - 참과 거짓을 판별할 수 있는 문장
// true, false
/*
 조건식 : 비교연산자를 가지고 만든다
 >
 <
 >=
 <=
 ==
 !=
 ===(같은 참조인지 판단)
 !==
 */

var a1 = 333
var a2 = 333
a1 == a2

/*
 조건을 병합 연결 키워드
 and : &&
 or : ||
 not : !
 */

// 삼항연산자
var test = number1 > 100 ? "Big" : "Small"
var test2:String!
if number1 > 100 {
    test2 = "Big"
} else {
    test2 = "Small"
}

// Switch Case(break 없음)
switch number1 {
case 100:
    print("1")
case 200, 202, 203:
    print("2")
case 300, 301, 302:
    print("3")
case 404:
    print("4")
case 500...550:
    print("5")
default:
    print("a")
}

// 루프 반복문 : 같은 행위를 여러번 하려고
// for 몇회 반복, 이터레이션
for i in 1...100 where i % 2 == 0 {
    print(i)
}

for _ in 1...5 {
    print("hello")
}

var i = 1
while i < 6 {
    print(i)
    i += 1
}

// 복합할당 연산자 : +=, -=, *=, /=

repeat {
    print("aaa")
    i += 1
} while i < 10

// 함수
func testFunc() {
    print("test")
}

testFunc()

func testFunc2(msg:String) {
    print(msg)
}

testFunc2(msg: "hello world")

func testFunc3(msg:String, type:Int) {
    print(msg, type)
}

testFunc3(msg: "hello world", type: 3)

func testFunc4(_ msg:String, type:Int) {
    print(msg, type)
}

testFunc4("asdf", type: 3)

func testFunc5(_ msg:String, _ type:Int) {
    print(msg, type)
}

testFunc5("asdf", 3)

// 기본값 지정 가능
func testFunc6(msg:String = "test", type:Int) {
    print(msg, type)
}

testFunc6(type: 30)
