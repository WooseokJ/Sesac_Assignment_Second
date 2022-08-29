//: [Previous](@previous)

import Foundation

//MARK: 서버응답값(json)을 좀 변경해서 모델(struct)로 넣고싶은경우
let json = """
{
"quote_content": "I think that the good and the great are only separated by the willingness to sacrifice.",
"author_name": null
"likeCount": 12345
}
"""

struct Quote : Decodable { // 데이터 타입이 만약 옵셔널타입이면 옵셔널로 받아야한다.
    let ment: String
    let author: String
    let like: Int
    let isInfluencer: Bool // 10000이상 좋아요 받은경우
    
    
    
    
    enum codingKeys: String, CodingKey {
        case ment = "quote_content"
        case author = "author_name"
        case like = "likeCount"
    }
    
    init(from decoder: Decoder) throws { // 디코더할떄 어떻게 초기화할까 , 새로운값 들어오거나 다른값으로 바꿔줄경우쓴다.
        let container = try decoder.container(keyedBy: codingKeys.self)
        ment = try container.decode(String.self, forKey: .ment) // codingKeys의 ment를 String기반으로 let ment에 담아줄게
        author = try container.decodeIfPresent(String.self, forKey: .author) ?? "unknown" //author_name이 null일떄 ifpresent사용해서 대체가능
        like = try container.decode(Int.self, forKey: .like)
        isInfluencer = (10000...).contains(like) ? true : false
    }
    
}

// 디코딩: json을 -> struct에 담음 (이게좀더많이쓰여)   / 인코딩: 스위프트에만있는걸(struct) -> json(누구나쓸수있게)
// string -> data -> quote

//string -> data(json)
guard let result = json.data(using: .utf8) else {fatalError("Error")}
print(result)

//data(json) -> quote(모델로)
do{
    let value = try JSONDecoder().decode(Quote.self, from: result)
    print(value)
    print(value.ment)
    print(value.author)
    
}catch {
    print(error)
}
