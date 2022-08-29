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
encoder.outputFormatting = .prettyPrinted
//encoder.dateEncodingStrategy = .iso8601 //iso

let format = DateFormatter()
format.locale = Locale(identifier: "ko-KR")
format.dateFormat = "MM월 dd일 hh:mm:ss EEEE"

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
