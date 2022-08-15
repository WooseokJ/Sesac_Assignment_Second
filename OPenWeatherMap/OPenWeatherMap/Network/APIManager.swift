
import Foundation

import Alamofire
import SwiftyJSON

class APIManager {
    static var shared = APIManager()
    private init() {}
    func weatherDataNetwork( lat:Double, longi:Double, completionHandler: @escaping (datastruct) -> () ) {
        let url = EndPoint.weatherURL + "lat=\(lat)&lon=\(longi)&appid=" + APIKey.key
        
        AF.request(url, method: .get).validate(statusCode: 200...500).responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print(json)
                let valueList = datastruct (
                        icon: json["weather"][0]["icon"].stringValue,
                        humidity:json["main"]["humidity"].stringValue,
                        temp: json["main"]["temp"].doubleValue,
                        windy: json["wind"]["speed"].stringValue
                )
                completionHandler(valueList)
            case .failure(let error):
                print(error)
            }
        }
    }

    
}





