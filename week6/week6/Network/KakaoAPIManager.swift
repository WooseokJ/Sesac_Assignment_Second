
import Foundation

import Alamofire
import SwiftyJSON

//sample
struct User { //private를 하면 안에 public,interval같이 작은쪽은 쓸수없다. , 그리고 초기화할필요도 없어진다. ,기본은 interval이므로 초기화는 되지만 각 원소(name,age)들은 불러올수없다.
    fileprivate let name = "고래밥" //같은 스위프트 파일에서 다른클래스,구조체 사용가능,다른 스위프트 파일은 X
    private let age = 11 //같은 스위프트 파일내에서만 쓸수있다.
}

extension User {
    func example() {
        print(self.name,self.age)
    }
}

struct Person {
    func example() {
        let user = User()
        user.name
//        user.age // X
    }
}

class KakaoAPIManager {
    static let shared = KakaoAPIManager()
    
    private init() { }
    private let header : HTTPHeaders = ["Authorization" : "KakaoAK \(APIKey.kakao)"]
    
    func callRequest(query: String,type: EndPoint, completionHandler: @escaping(JSON) -> () ) { //json파일 인풋
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}   // 글자가 들어올떄 인코딩 
        // EndPoint.blog.requestURL: ~blog?query=
        let url = type.requestURL + query // EndPoint.(blog,cafe).requestURL + query
        
        AF.request(url, method: .get ,headers: header).validate().responseData { [self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                completionHandler(json)
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
}
