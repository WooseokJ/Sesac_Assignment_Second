//: [Previous](@previous)

import Foundation

//MARK: codable
let json = """
{
"quote_content": "I think that the good and the great are only separated by the willingness to sacrifice.",
"author_name": "Kareem Abdul-Jabbar"
}
"""

struct Quote : Decodable { // 데이터 타입이 만약 옵셔널타입이면 옵셔널로 받아야한다. 
    let quoteContent: String
    let authorName: String
}

// 디코딩: json을 -> struct에 담음 (이게좀더많이쓰여)   / 인코딩: 스위프트에만있는걸(struct) -> json(누구나쓸수있게)
// string -> data -> quote

//string -> data(json)
guard let result = json.data(using: .utf8) else {fatalError("Error")}
print(result)

let decoder = JSONDecoder()
//snakecase(_) 속성 chage    _ -> N(Name)으로     디코딩 전략
decoder.keyDecodingStrategy = .convertFromSnakeCase
//data(json) -> quote(모델로)
do{
    let value = try decoder.decode(Quote.self, from: result)
    print(value)
    print(value.quoteContent)
    print(value.authorName)
    
}catch {
    print(error)
}

