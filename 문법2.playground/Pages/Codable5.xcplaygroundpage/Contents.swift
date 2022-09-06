//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"
// https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=861
let json = """
{"totSellamnt":81032551000,"returnValue":"success","drwNoDate":"2019-06-01","firstWinamnt":4872108844,"drwtNo6":25,"drwtNo4":21,"firstPrzwnerCo":4,"drwtNo5":22,"bnusNo":24,"firstAccumamnt":19488435376,"drwNo":861,"drwtNo2":17,"drwtNo3":19,"drwtNo1":11}
"""

struct Lotto: Codable { // codable 은 decodable, encodable둘다 모두 채택할수있는 타입앨리어스(typeAliases)이다.
    let totSellamnt: Int
    let returnValue, drwNoDate: String
    let firstWinamnt, drwtNo6, drwtNo4, firstPrzwnerCo: Int
    let drwtNo5, bnusNo, firstAccumamnt, drwNo: Int
    let drwtNo2, drwtNo3, drwtNo1: Int
}


guard let result = json.data(using: .utf8) else {fatalError("Error")}
print(result)

let decoder = JSONDecoder()
//snakecase(_) 속성 chage    _ -> N(Name)으로     디코딩 전략
decoder.keyDecodingStrategy = .convertFromSnakeCase
//data(json) -> quote(모델로)
do{
    let value = try decoder.decode(Lotto.self, from: result)
    print(value)
    print(value.drwNoDate)
    print(value.drwtNo5)
    
}catch {
    print(error)
}




//: [Next](@next)
