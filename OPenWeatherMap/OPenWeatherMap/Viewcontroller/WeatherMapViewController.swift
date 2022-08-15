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
    // 습도 라벨
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
    // 백그라운드 배경 이미지
    @IBOutlet weak var backGroundImageView: UIImageView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        APIManager.shared.weatherDataNetwork(lat: 37.517829, longi: 126.886270) { data in
            DispatchQueue.main.async {
                print(data)
                self.design(data: data)
            }
        }
        checkUserDeviceLocationSeriveAuthorization()
    }
}


extension WeatherMapViewController {
    
    func design(data: datastruct) {
        let date = Date()
        let formattor = DateFormatter()
        formattor.dateFormat = "MM/dd/yyyy hh:mm:ss : EE"
        let dateString = formattor.string(from: date)
        //날짜 디자인
        dateLabel.datelabelDesign(text: dateString)
        //위치 버튼 디자인
        locationButton.ButtonDesign(imageName: "location.fill")
        // 위치 라벨 디자인
        locationLabel.locationLabelDesign(text: "")
        //공유하기 버튼 디자인
        sharedButton.ButtonDesign(imageName: "square.and.arrow.up")
        // 새로고침 버튼 디자인
        refreshButton.ButtonDesign(imageName: "arrow.counterclockwise")
        // 온도 백그라운드 뷰
        tempBackView.backUIViewDesign()
        // 온도 라벨
        tempLabel.tempLabelDesign(text: data.temp - 273.15)
        // 속보 백그라운드뷰
        humidityBackView.backUIViewDesign()
        // 습도 라벨
        humidityLabel.humidityLabelDesign(text: data.humidity)
        // 풍량 백그라운드뷰
        windyBackView.backUIViewDesign()
        // 풍량 라벨
        windyLabel.windyLabelDesign(text: data.windy)
        // 이미지 백그라운드뷰
        imageBackView.backUIViewDesign()
        //이미지 뷰
        imageView.imageViewDesign(text: EndPoint.imageURL+"\(data.icon)@2x.png")
        // 좋은날 백그라운드뷰
        nicedayBackView.backUIViewDesign()
        //좋은날 라벨
        niceDayLabel.niceDayLabelDesign()
        // 백그라운드 뷰
        backGroundImageView.imageViewDesign(text: "http://i.pinimg.com/736x/10/13/88/10138835ec106b4a116501956e049516.jpg")
    }
    
    // 위치기반 불러오기
    func checkUserDeviceLocationSeriveAuthorization() {
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            
            authorizationStatus = locationManager.authorizationStatus
        } else{
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        if CLLocationManager.locationServicesEnabled() {
          
            checkUserCurrentLocationAuthorization(authorizationStatus)
        } else {
            print("위치 서비스꺼져있어 위치권한요청 못함")
        }
    }
    
    
    
    func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined :
            print("notDetermined")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()

        
        case .restricted, .denied: print("denied, 아이폰 설정 유도")
        
        case .authorizedWhenInUse:
            print("when in use")
            
            locationManager.startUpdatingLocation()
        default: print("default")
        }
    }
    
}

extension WeatherMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function,locations)
        
        if let cooridinate = locations.last?.coordinate {
            let findLocation = CLLocation(latitude: cooridinate.latitude, longitude: cooridinate.longitude)
            let geocoder = CLGeocoder()
            let locale = Locale(identifier: "Ko-kr") //원하는 언어의 나라 코드를 넣어주시면 됩니다.
            geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale) { [weak self] placemarks, _ in
                guard let placemarks = placemarks, let address = placemarks.last else { return }
                let s : CLPlacemark? = placemarks[0]
                
                print(s?.region)
                print(s?.administrativeArea)
                print(s?.subLocality)
                print(s?.thoroughfare)
                print(s?.subThoroughfare)
//                APIManager.shared.weatherDataNetwork(lat: cooridinate.latitude, longi: cooridinate.longitude) { data in
//                DispatchQueue.main.async {
//                    self!.design(data: data)
//                    }
//                }
            }
            
        }
       
        
        locationManager.stopUpdatingHeading()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkUserDeviceLocationSeriveAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
    }
    
}
