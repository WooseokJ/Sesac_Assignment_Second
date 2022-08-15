//
//  dataStruct.swift
//  OPenWeatherMap
//
//  Created by useok on 2022/08/15.
//

import Foundation

struct datastruct {
    
    var icon : String
    var humidity : String
    var temp : Double
    var windy: String
    init(icon: String, humidity: String, temp: Double, windy: String) {
        self.icon = icon
        self.humidity = humidity
        self.temp = temp
        self.windy = windy
    }
}
