
import Foundation

import Alamofire
import SwiftyJSON

class APIManager {
    static var shared = APIManager()
    private init() {}
    func weatherDataNetwork(lat:Double,longi:Double,completionHandler: @escaping (datastruct) -> () ) {
        let url = EndPoint.weatherURL + "lat=\(lat)&lon=\(longi)&appid=" + APIKey.key
        AF.request(url, method: .get).validate(statusCode: 200...500).responseData { response in
            switch response.result {
            case .success(let value):
                let dataList : [datastruct] = []
                let json = JSON(value)
                for i in json.arrayValue
                {
                    print(i)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestImage(lat: Double, longi: Double,completionHandler: @escaping ([datastruct]) -> ()) {
        var posterList: [[String]] = []
        APIManager.shared.weatherDataNetwork(lat: lat, longi: longi) { value in
        }
    }
}





