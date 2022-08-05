//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"
/*
//1급 객체(함수의확장) , 클로저

// 스위프트 특성 1.객체지향,2.함수형프로그래밍,3.프로토콜지향
 
// 1급객체 특성
1. var,let에 함수를 대입할수있다.
2. 함수의 인자값 함수를 사용할수있다
3.함수의 반환 타입으로 함수사용가능


*/
func checkBankInfo(bank: String) -> Bool {
    let bankArray = ["국민","우리","신한"]
    return bankArray.contains(bank) ? true : false
}

// let,var 에 함수가실행된 반환값이 대입된것.
let checkResult = checkBankInfo(bank: "우리") //함수를 상수에 담는과정   Bool타입 대입
print(checkResult) //true\n

// var,let에 함수자체를 대입할수있다(1급객체의특성) , 단지 함수만넣은거 실행되지않음
let checkAccount = checkBankInfo  // ()없어서 실행된거 아님

//checkAccount 상세보기하면 (string) -> Bool 이게뭐냐?    function type (ex. tuple)
let tupleExmaple = (1,2,"hi",true)
tupleExmaple.2 //hi

//함수 호출해주어야 ()     실행됨.
checkAccount("신한") //true , 파라미터 필요없음.


// 스위프트 3 부터 괄호명시
func hello(username: String) -> String {
    return "저는\(username)입니다 username"
}
func hello(nickname: String,age: Int) -> String {
    return "저는\(nickname),입니다 nickname 나이: \(age)살"
}
// 오버로딩 특성떄문에 함수구분힘듬. 타입어노테이션통해 함수를 구별
//let result = hello // 오류나는건 hello가 두개라서 어떤걸써야되는지 몰라서 오류
// 함수표기법 사용하면 타입어노테이션 생략해도 함수구별가능
//let result1 : (String)-> String = hello  // 입력,반환값 타입이 동일한게 두개면 오류남(Ambiguous use of 'hello')
let result1 : (String) -> String = hello(username: )
let result2 : (String ,Int)-> String = hello
result1("죠스바")
result2("고래밥",20)

func hello(nickname: String) -> String {
    return "저는\(nickname)이에요 nickname"
}


// 2.함수의 반환 타입으로 함수사용가능
func currentAccount() -> String {
    return "계좌잇음"
}

func noCurrentAccount() -> String {
    return "계좌없음"
}
currentAccount // ()->String

// 가장 왼쪽에 위치한 -> 를 기준으로 오른쪽에 놓인 모든타입을 반환값을 의미한다.

func checkBank(bank: String) -> () -> String {
    let bankArray = ["우리","신한","국민"]
    return bankArray.contains(bank) ? currentAccount : noCurrentAccount // 함수를 호출하는것은 아니고 함수를 던져줌
}

let result = checkBank(bank: "농협")
result() // 계좌없음





// 2-1 Calculate

func plus(a:Int,b:Int) -> Int{
    return a+b
}
func mius(a:Int,b:Int) -> Int{
    return a-b
}
func multiply(a:Int,b:Int) -> Int{
    return a*b
}
func divide(a:Int,b:Int) -> Int{
    return a/b
}
func calculate(operand: String) -> (Int, Int) -> Int {
    switch operand{
    case "+" : return plus
    case "-" : return mius
    case "*" : return multiply
    case "/" : return divide
    default: return plus
    }
}
let resultCalc = calculate(operand: "+") // 함수 실행상태아님 (Int, Int) -> Int
resultCalc(4,5) //9

//2번 특성
func oddNum() {
    print("홀")
}
func evenNum() { // ()->()
    print("짝")
}
evenNum // ()->()
func resultNum(num:Int, odd:() -> (), even: ()-> () ) { //odd,even은 함수타입
    return num.isMultiple(of: 2) ? even() : odd()
}

//메개변수로 함수전달
resultNum(num: 9, odd: {print("홀수")}, even: {print("짝수")})

resultNum(num: 9, odd: oddNum, even: evenNum)

resultNum(num: 9){
} even: {
    
}


//MARK: 클로저는 이름없는함수
// () -> ()      in 기준으로      클로저해더()->()   in   클로저바디(print)
let studyios = { () -> () in
    print("주말에도 공부하기")
}
studyios // ()->()           printt실행 안됨. 함수만 정의한거
studyios() // print실행   ()는 함수실행(호출)

func getStudyWithMe(study: ()->() ) {
    study()
}
//코드를 생략하지않고 클로저 구문씀, 함수 매개변수내에 클로저가 그대로 들어간형태   -> 인라인 클로저
getStudyWithMe(study: { () -> () in //getStudyWithMe(study: studyios) 와 동일 (
    print("주말에도 공부하기")
})

//MARK:


func randomNum(result : (Int) -> String) {
//    result() //오류 input에 int값 필요
    result(Int.random(in: 1...10))
}

//넷다 동일( 클로저 표현식)
randomNum(result: { (number: Int) -> String in
    return "행운의숫자는 \(number)"
})

randomNum(result: { ( number )in
    return "행운의숫자는 \(number)"
})
// 매개변수 생략되면 할당된 내부상수 $0, $1, $2...를 사용할수있다.
randomNum(result: {
    "행운의숫자는 \($0)"
})
randomNum() { //이거 를 가장많이사용   함수안에 함수를 정의햇구나로 생각해도됨.
    "행운의숫자는 \($0)"
}

// 시간측정
func processTime(code: () -> () ) {
    let start = CFAbsoluteTimeGetCurrent() //2001년기준으로 double 타입으로 나옴
    code()
    let end = CFAbsoluteTimeGetCurrent() - start
    print(end)
}


//MARK: 고차함수 filter map reduce
let student = [2.2, 4.4, 3.3, 1.1, 4.2,4.2 ,1.3 ,4.4 ,4.5 ,3.4 ,2.3]
//processTime {
//    var newStudent : [Double] = []
//    for s in student {
//        if s >= 4.0 {
//            newStudent.append(s)
//
//        }
//    }
//    print(newStudent)
//}
//4.0 이상학생 필터
let filterStudent = student.filter{ value in
    value >= 4.0
}
let filterStudent2 = student.filter{ $0 >= 4.0} //이게 더 성능빨라
//processTime {
//    print(filterStudent2)
//}

// map: 기존 요소를 원하는 클로저 통해 원하는 결과값으로 변경
let num = [Int](1...100) // [1,2,3...100]

let mapnum = num.map{$0 * 3}
mapnum //[3,6,9...300]
let movie = [
    "a":"A",
    "b":"B",
    "c":"C",
    "d":"A"
]

let movieResult = movie.filter {$0.value == "A"}
print(movieResult) //["a":"A","d":"A"]
let movieResult2 = movie.filter {$0.value == "A"}.map { $0.key}
print(movieResult2) // ["a","d"]

let examScore : [Double] = [1,2,3,4,5]

let totalCountUsingReduce = examScore.reduce(10){// 배열에 10 더하기
    return $0 + $1 // 10더한 배열값 모두다 더하기
    
}
print(totalCountUsingReduce)


//클로저 사용 문제점
func game(item: Int) -> String {
    func luckNum(num: Int) -> String {
        return "\(num * Int.random(in: 1...10))"
    }
    let result = luckNum(num: item)
    return result
}

game(item: 10) // 외부함수의 생명주기가 끝난다.

// 내부함수 반환하는 외부함수만들수있음. (일반적으론 외부함수에서 내부함수를 쓸수밖에없음)

func game2(item: Int)-> ()->String {
    func luckNum2()->String {
        return "\(item * Int.random(in: 1...10))"
    }
    return luckNum2
}
game2(item: 30)() // 외부함수는 생명주기 끝났지만 내부함수는 사용가능


//: [Next](@next)

