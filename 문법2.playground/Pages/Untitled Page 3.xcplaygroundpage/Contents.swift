//: [Previous](@previous)

import UIKit

/*
 meta type : 클래스,구조체,열거형 유형 가리킴
 String타입은 String.type
 */

struct User {
    let name = "고래밥" // 인스턴스 프로퍼티
    static let originalName = "jack" // 타입 프로퍼티
}
let user = User() //인스턴스로 name 호출 0 , originalName은 호출 X
user.name //고래밥
User.originalName //User.self.originalName 와 동일 //jack

type(of: user.name) // user.name String 타입의 인스턴스, "고래밥" - String Value, String 은 String.type

let intValue: Int = 9.self
let intType: Int.Type = Int.self

/*
 swift error handing: try,do,try catch
 */

func validate(text: String) -> Bool {
    //입력값 비었는지
    guard !(text.isEmpty) else {
        print("반값")
        return false
    }
    //입력값 숫자인지
    guard Int(text) != nil else {
        print("숫자아님")
        return false
    }
    return true
}

if validate(text: "20202"){ //영진원 박스오피스
    print("검색가능")
} else{
    print("검색불가")
}


enum validateError: Int, Error {
    case emptyString = 500
    case isNotInt = 400
    case isNotData
    case callLimit
    case serverError
}
func validateInputError(text: String) throws -> Bool {
    //입력값 비었는지
    guard !(text.isEmpty) else {
        throw validateError.emptyString
    }
    //입력값 숫자인지
    guard Int(text) != nil else {
        throw validateError.isNotInt
        
    }
    return true
}

do { //일단 진행해라, do쪽이 옳게만 사용 , 나머지 (catch)는 오류
    try validateInputError(text: "20202")  // try?, try! try  //true
    print("성공")
} catch validateError.emptyString { //문자 아니면 어떻게 처리할꺼냐?
    print("emptyString")
    
} catch validateError.isNotInt { //인트형 아니면 실행
    print("isnotInt")
} catch { //그이외 오류
    print("error")
}
