
import UIKit

import Alamofire
import SwiftyJSON
class ImageSearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
        
    }
    
    // fetchImage, requestImage, getImage, callRequestImage ...etc response에 따라 네이밍설명해주기도함.
    func fetchImage() {

        let text = "과자".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let header : HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret": APIKey.NAVER_SECRET]
        let url = EndPoint.imageSearchURL + "query=\(text)&display=30&start=1" // query와 start는 순서상관없음 ,  과자를 그냥넣으면 안됨. query= 내용은 과자를 UTF로 변환(%EA%B3%BC%EC%9E%90& 넣으면 나오긴함(네이버개발자센터 내용)
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseJSON { [self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
    }
    

}
