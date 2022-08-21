import Foundation
import Alamofire
import SwiftyJSON
import UIKit

// 싱글턴패턴은 클래스만 만든다.    (클래스 싱글턴 vs 구조체 싱글턴 )
class ImageSearchAPIManager {
    static let shared = ImageSearchAPIManager()
    typealias completionHandler = (Int,[String]) -> Void
    // non-escaping -> @escaping
    // fetchImage, requestImage, getImage, callRequestImage ...etc response에 따라 네이밍설명해주기도함.
    func fetchImageData(query: String,startpage: Int, completionHandler: @escaping completionHandler ) {
        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let header : HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret": APIKey.NAVER_SECRET]
        let url = EndPoint.imageSearchURL + "query=\(text)&display=30&start=\(startpage)" // query와 start는 순서상관없음 ,  과자를 그냥넣으면 안됨. query= 내용은 과자를 UTF로 변환(%EA%B3%BC%EC%9E%90& 넣으면 나오긴함(네이버개발자센터 내용)     startpage 부터 30개 갖고와라!
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseData { [self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                let totalCount = json["total"].intValue
//                total += json["total"].intValue   // 상속해서 total받으면 여러개의 뷰에서 상속받아야될경우도있을수있으니 적합하지않음.
//                for item in json["items"].arrayValue{
//                    // 셀에서 url,uiimage 변환 vs 서버통신받는 시점에서 url,uimage변환  (전자가 더 좋음, 이미지용량이 너무크면 서버통신받는시점에서는 오랜시간거림
//                    imageArray.append(item["link"].stringValue)
//                }
                let newresult = json["items"].arrayValue.map {$0["link"].stringValue}
//                imageArray.append(contentsOf: newresult)
                completionHandler(totalCount,newresult)

//                collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}


