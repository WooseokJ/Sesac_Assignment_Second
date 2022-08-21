// 앱처음실행시
// 1.locationManagerDidchageAuthorization (인스턴스생성시(CLLocationManager()) 호출,권한상태변경)_
// 2.checkUserDeviceLocationServiceAuthorization //위치서비스 활성화 on인경우
// 3.checkUsercurrentLocationAuthorization //현재상태확인 - notdetermined
// 4권한버튼 사용자가 클릭하면 notdetermined -> 다시 위에1번으로 돌아감(5,6,7) ->3번까지 다시오면 wheninUse가 다시실행 8

import UIKit
import MapKit
// MARK: locationn 1. 위치관련된거 모두 임포트
import CoreLocation
class MapViewController: UIViewController {
    /**
    지도와 위치권한은 전혀 상관이 X
     만약 지도에 현재위치등 표현하려면 -> 위치권한 등록해야함
     핀(=어노테이션)
     */
/**
 권한 : 반영이 조금 느릴수있음, 지웟다가 실행한다고 하더라도., 한번허용
 */
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: location2. 위치에 대한 대부분 담당.
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: location3. 프로토콜 연결
        locationManager.delegate = self
        // 지도 중심설정: 애플맵활용해 좌표복사
        let center = CLLocationCoordinate2D(latitude: 37.555908, longitude: 126.973262) //위도경도
        setReginAndAnnotation(center: center)
    }
    // 지도띄우기함수
    func setReginAndAnnotation(center:CLLocationCoordinate2D) {
        // 지도 중심기반으로 보여질범위설정.
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000) // center 는 지도에서 처음나오는부문 에 중앙위치 ,lati~,long~은 지도 줌 크기
        mapView.setRegion(region, animated: true)
        
        //지도에 핀 추가
        let annotation = MKPointAnnotation()
        annotation.coordinate = center //coordinate: 좌표
        annotation.title = "새싹 캠퍼스"
        mapView.addAnnotation(annotation)
    }
}


// 위치 관련된 user defined 메서드
extension MapViewController {
    // MARK: location7. ios 버전에 따른 분기처리 및 ios 위치 서비스 활성화 여부 확인
    // 위치서비스가 켜져있으면 권한요청, 꺼져있으면 커스텀앨럿으로 상황알려주기(ex..켜달라고 알려줘)
    // CLAuthorizationStatus
    // -denied: 허용안함(ex..설정에서 추후에 거부,위치서비스 중지.비행기모드)
    // -restricted:허용안함으로 deniend와 유사하지만 denied와 차이가잇음(제한을걸수있음): 앱에서 권한자체가 없는경우,자녀보호기능같은걸로 제한.
    func checkUserDeviceLocationSeriveAuthorization() { //위치서비스 활성화 확인
        let authorizationStatus: CLAuthorizationStatus
        //  CLAuthorizationStatus 상태확인.
        if #available(iOS 14.0, *) {
            //인스턴스(locationManager) 통해 인스턴스가 가지고있는 상태를 가져옴.
            authorizationStatus = locationManager.authorizationStatus
        } else{
            authorizationStatus = CLLocationManager.authorizationStatus() //이는 ios14이후에 없어짐, 이전은사용가능
        }
        //ios 위치 서비스 활성화 여부 체크
        if CLLocationManager.locationServicesEnabled() {
          //위치 서비스 활성화되므로 위치권한 요청가능하니까 위치권한 요청
            checkUserCurrentLocationAuthorization(authorizationStatus)
        } else {
            print("위치 서비스꺼져있어 위치권한요청 못함")
        }
    }
    
    // MARK: location8: 사용자의 현재상태 체크
    // 사용자가 위치를 허용,거부햇는지,아직선택하지않앗는지등 확인(단,사전에 ios 위치서비스 활성화 꼭 확인)
    func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined :
            print("notDetermined")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization() //앱사용하는동안 위치관련요청
//            locationManager.startUpdatingLocation() //없어도 괜찮지않을까?
        //허용 거부
        case .restricted, .denied:
            print("denied, 아이폰 설정 유도")
            showRequestLocationServiceAlert()
        //앱을사용하는동안
        case .authorizedWhenInUse:
            print("when in use")
            //사용자가 위치 허용해두면 startupdatingLocation통해 didupdateLocation 메소드가 실행.
            locationManager.startUpdatingLocation()
        default: print("default")
        }
    }
    
    func showRequestLocationServiceAlert() {
      let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
      let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
          //성정까지 이동하거나 설정 세부화면까지 이동하거나
          //한번도설정앱에 들어가지않은경우, 막다운받은앱이거나
          if let appSetting = URL(string: UIApplication.openSettingsURLString) {
              UIApplication.shared.open(appSetting)
          }
      }
      let cancel = UIAlertAction(title: "취소", style: .default)
      requestLocationServiceAlert.addAction(cancel)
      requestLocationServiceAlert.addAction(goSetting)
      
      present(requestLocationServiceAlert, animated: true, completion: nil)
    }
}


// MARK:  location4. 프로토콜선언
extension MapViewController: CLLocationManagerDelegate {
    // MARK: location5 : 사용자의 위치를 성공적으로 가져온경우(didUpdateLocation)
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function,locations)
        // ex.. 위치정보가져올떄 날씨정보조회, 및 지도다시세팅
        if let cooridinate = locations.last?.coordinate {
            setReginAndAnnotation(center: cooridinate) //coordinate 좌표
        }
        // 위치 업데이트 멈춰 (실시간성이 중요한거는 매번쓰고, 중요하지않은건 원하는 시점에 써라)
        locationManager.stopUpdatingHeading()
    }
    // MARK: lovation6: 사용자의 위치를 못가져온경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
    // MARK: lovation9: 사용자 권한상태가 바뀔떄 알려줌
    // 거부했다가 설정에서 변경, 혹은 notdetermined에서 허용을 눌렀거나
    // 허용햇다가 위치가져오는중 설정에서 거부하고 돌아온다면?
    //ios 14이상 : 사용자 권한상태가 변경될떄 위치관리자 생성시 호출
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkUserDeviceLocationSeriveAuthorization()
    }
    //ios 14미만
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
    }
}


extension MapViewController: MKMapViewDelegate {
    
    //viewFor : 지도에 핀을 커스텀하게 다룸(ex...핀모양같은거)
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        <#code#>
//    }
    
    // 사용자가 지도 멈추면 동작
//    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
//        <#code#>
//    }

    
}

