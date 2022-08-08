//
//  Endpoint.swift
//  week6
//
//  Created by useok on 2022/08/08.
//

import Foundation

enum EndPoint {
//    방법1
//    static let blog = "https://dapi.kakao.com/v2/search/blog"
//    static let cafe = "https://dapi.kakao.com/v2/search/cafe"
    
//    방법2
//    static let blog = "\(URL.baseURL)blog"
//    static let cafe = "\(URL.baseURL)cafe"
     
//  방법3
    case blog,cafe
    var requestURL : String{
        switch self {
        case .blog:
            return URL.makeEndPointSting("blog?query=")
        case .cafe:
            return URL.makeEndPointSting("cafe?query=")
        }
    }
}
