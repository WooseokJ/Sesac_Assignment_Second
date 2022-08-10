
import Foundation

import Alamofire
import SwiftyJSON

class TMDBAPIManager {
    static let shared = TMDBAPIManager()
    private init() {} //초기화안되게방지
    let tvList = [
        ("환혼", 135157),
        ("이상한 변호사 우영우", 197067),
        ("인사이더", 135655),
        ("미스터 션사인", 75820),
        ("스카이 캐슬", 84327),
        ("사랑의 불시착", 94796),
        ("이태원 클라스", 96162),
        ("호텔 델루나", 90447)
    ]
    let imageURL = "https://image.tmdb.org/t/p/w500"
//    let seasonURL = "https://api.themoviedb.org/3/tv/135157/season/1?api_key=\(APIKey.tmdb)&language=ko-KR"
    
    func callRequest(query: Int, completionHandler: @escaping([String]) -> () ) { //json파일 인풋
        let url  = "https://api.themoviedb.org/3/tv/\(query)/season/1?api_key=\(APIKey.tmdb)&language=ko-KR"
        AF.request(url, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                // json으로 stillPath 담아내기 -> [String]
                var stillArray : [String] = []
                for item in json["episodes"].arrayValue {
                    stillArray.append(item["still_path"].stringValue)
                }
//                dump(self.tvList)
//                dump(stillArray) 복합적인데이터출력시좋아(배열,튜플,등등)
                print(stillArray)
                let value = json["episodes"].arrayValue.map{$0["still_path"].stringValue}
                print(value)
                completionHandler(value)
            case .failure(let error):
                print(error)
            }
        }

    }
    
    // 나중에 배울거! async/await(ios 13이상) 아래 문제 해결위해 나옴. 
    
    func requestImage(completionHandler: @escaping ([[String]]) -> ()) {
        
        var posterList: [[String]] = []
        
        TMDBAPIManager.shared.callRequest(query: tvList[0].1) { value in
            posterList.append(value)
            
            TMDBAPIManager.shared.callRequest(query: self.tvList[1].1) { value in
                posterList.append(value)
                
                TMDBAPIManager.shared.callRequest(query: self.tvList[2].1) { value in
                    posterList.append(value)
                    
                    TMDBAPIManager.shared.callRequest(query: self.tvList[3].1) { value in
                        posterList.append(value)
                        
                        TMDBAPIManager.shared.callRequest(query: self.tvList[4].1) { value in
                            posterList.append(value)
                            
                            TMDBAPIManager.shared.callRequest(query: self.tvList[5].1) { value in
                                posterList.append(value)
                                
                                TMDBAPIManager.shared.callRequest(query: self.tvList[6].1) { value in
                                    posterList.append(value)
                                    
                                    TMDBAPIManager.shared.callRequest(query: self.tvList[7].1) { value in
                                        posterList.append(value)
                                        completionHandler(posterList)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }


    func requestEpisodeImage() {
        // 어떤 문제가 생길수있을까요? -> 1.순서보장 x, 2. 언제끝날지 모름 3. 제한있을수있음(ex.1초에 5번 block) -> 다음주해결
//        for item in tvList {
//            TMDBAPIManager.shared.callRequest(query: item.1)  { stillPath in
//                print(stillPath)
//            }
//        }
        let id = tvList[7].1// 90447
        TMDBAPIManager.shared.callRequest(query: id) { stillPath in
            print(stillPath)
            TMDBAPIManager.shared.callRequest(query: self.tvList[5].1) { stillPath in
                print(stillPath)
            }
            
        }
    }
    
}
