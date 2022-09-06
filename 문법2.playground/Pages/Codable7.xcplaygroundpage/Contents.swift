//: [Previous](@previous)

import Foundation
// MARK: - 실습

let json = """
{
"totSellamnt":81032551000,"returnValue":"success","drwNoDate":"2019-06-01"
    ,"firstWinamnt":4872108844,"drwtNo6":25,"drwtNo4":21,"firstPrzwnerCo":4
    ,"drwtNo5":22,"bnusNo":24,"firstAccumamnt":19488435376
    ,"drwNo":861,"drwtNo2":17,"drwtNo3":19,"drwtNo1":11
}
"""

//struct Lotto: Decodable {
//    let drwNoDate: String
//    let drwtNo5: Int
//}

struct Lotto: Codable {
    let totSellamnt: Int
    let returnValue, drwNoDate: String
    let firstWinamnt, drwtNo6, drwtNo4, firstPrzwnerCo: Int
    let drwtNo5, bnusNo, firstAccumamnt, drwNo: Int
    let drwtNo2, drwtNo3, drwtNo1: Int
}


//1. String -> Data
guard let result = json.data(using: .utf8) else { fatalError("ERROR") }
print(result)


//2. Data -> Quote
do {
    let value = try JSONDecoder().decode(Lotto.self, from: result)
    print("🍖 -> \(value)")
} catch {
    print(error)
}
















//: [Next](@next)
