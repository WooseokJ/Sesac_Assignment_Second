
import Foundation

import Alamofire
import SwiftyJSON

class KakaoAPIManager {
    static let shared = KakaoAPIManager()
    
    private init() { }
    let header : HTTPHeaders = ["Authorization" : "KakaoAK \(APIKey.kakao)"]
    
    func callRequest(query: String,type: EndPoint, completionHandler: @escaping(JSON) -> () ) { //json파일 인풋
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        // EndPoint.blog.requestURL: ~blog?query=
        let url = type.requestURL + query // EndPoint.(blog,cafe).requestURL + query
        
        AF.request(url, method: .get ,headers: header).validate().responseJSON { [self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(#function)
                print("JSON: \(json)")
                
                completionHandler(json)
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
}
