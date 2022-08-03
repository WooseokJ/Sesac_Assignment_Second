//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"
/*
//1급 객체(함수의확장) , 클로저

// 스위프트 특성 1.객체지향,2.함수형프로그래밍,3.프로토콜지향
// 1급객체 특성
1. var,let에 함수를 대입할수있다.
2. 함수의 인자값


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

//2번 특성
func oddNum() {
    print("홀")
}
func evenNum() {
    print("짝")
}
func resultNum(num:Int, odd:() -> (), even: ()-> () ) { //odd,even은 함수타입
    return num.isMultiple(of: 2) ? even() : odd()
}
//메개변수로 함수전달
resultNum(num: 9, odd: oddNum, even: evenNum)


//: [Next](@next)
