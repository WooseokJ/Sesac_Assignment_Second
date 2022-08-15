//
//  dataStruct.swift
//  OPenWeatherMap
//
//  Created by useok on 2022/08/15.
//

import Foundation

struct datastruct {
    var name : String
    var icon : String
    var humidity : String
    var temp : String
    init(name: String, icon: String, humidity: String, temp: String) {
        self.name = name
        self.icon = icon
        self.humidity = humidity
        self.temp = temp
    }
}
