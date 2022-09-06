//: [Previous](@previous)

import Foundation

struct User: Encodable{
    let name: String
    let singDate: Date
    let age: Int
}

let users: [User] = [
    User(name: "Jack", singDate: Date(), age: 33),
    User(name: "Elsa", singDate: Date(timeInterval: -86400, since: Date()), age: 18),
    User(name: "Emily", singDate: Date(timeIntervalSinceNow: 86400*2), age: 31)
]

let encoder = JSONEncoder()
//json 형태처럼 만들어줌
encoder.outputFormatting = .prettyPrinted
//iso8601: 날짜와 시간 관련된 데이터 교환을 다루는 국제 표준
encoder.dateEncodingStrategy = .iso8601 //iso

let format = DateFormatter()
format.locale = Locale(identifier: "ko-KR")
format.dateFormat = "MM월 dd일 hh:mm:ss EEEE"

encoder.dateEncodingStrategy = .formatted(format)

do {
    
    let result = try encoder.encode(users) //  user(json) -> data
    print(result)
    // data -> string
    guard let jsonString = String(data: result, encoding: .utf8) else{
        fatalError("error")
    }
    print(jsonString)
    
} catch {
    print(error)
}

//: [Next](@next)
