//
//  WeatherMapViewController.swift
//  OPenWeatherMap
//
//  Created by useok on 2022/08/15.
//

import UIKit
import CoreLocation
import SwiftyJSON


class WeatherMapViewController: UIViewController {
    // 날짜
    @IBOutlet weak var dateLabel: UILabel!
    // 위치버튼
    @IBOutlet weak var locationButton: UIButton!
    // 위치라벨
    @IBOutlet weak var locationLabel: UILabel!
    // 공유하기 버튼
    @IBOutlet weak var sharedButton: UIButton!
    // 새로고침 버튼
    @IBOutlet weak var refreshButton: UIButton!
    // 온도 백그라운드뷰
    @IBOutlet weak var tempBackView: UIView!
    // 온도 라벨
    @IBOutlet weak var tempLabel: UILabel!
    // 슥보 백그라운드뷰
    @IBOutlet weak var humidityBackView: UIView!
    // 슥도 라벨
    @IBOutlet weak var humidityLabel: UILabel!
    // 풍량 백그라운드뷰
    @IBOutlet weak var windyBackView: UIView!
    // 풍량 라벨
    @IBOutlet weak var windyLabel: UILabel!
    // 이미지 백그라운드뷰
    @IBOutlet weak var imageBackView: UIView!
    // 이미지뷰
    @IBOutlet weak var imageView: UIImageView!
    // 좋은날 백그라운드뷰
    @IBOutlet weak var nicedayBackView: UIView!
    // 좋은날 라벨
    @IBOutlet weak var niceDayLabel: UILabel!
        
    var jsonData : [datastruct] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIManager.shared.requestImage(lat: 37.517829, longi: 126.886270) { data in
            self.jsonData = data
        }
    }
    
    
    

}
