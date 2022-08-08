//
//  URL+Extension.swift
//  week6
//
//  Created by useok on 2022/08/08.
//

import Foundation


extension URL {
    //    static let blog = "https://dapi.kakao.com/v2/search/blog"
    //    static let cafe = "https://dapi.kakao.com/v2/search/cafe"
    
    static let baseURL = "https://dapi.kakao.com/v2/search/"
    
    static func makeEndPointSting(_ endpoint: String) -> String {
        return baseURL + endpoint
    }
   
    

}
