
import UIKit

class LocationViewController: UIViewController {
//    static var reuseIdentifier: String = String(describing: LocationViewController.self) //LocationViewController.self(메타타입) => "LocationViewController"



    //MARK: notification 1.
    let notificationCenter = UNUserNotificationCenter.current() // 알람할떄 선행되야됨.
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestAuthorization()
        for i in UIFont.familyNames{
            print("======\(i)======")
            for name in UIFont.fontNames(forFamilyName: i){
                print(name)
            }
        }
    }
    
    @IBAction func noticationButtonClicked(_ sender: UIButton) {
        sendNotification()
    }
    
    
    //MARK: notification 2. 권한요청
    func requestAuthorization(){
        let authrozationOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        
        notificationCenter.requestAuthorization(options: authrozationOptions){success,error in
            if success{
                self.sendNotification()
            }
            
        }
    }
    //MARK: notification 2. 권한 허용한 사용자에게 알림 요청(언제,어떤컨텐츠?)
    // ios 시스템에서 알림담당->알림등록
    
    /*
     - 권한 허용해야만 알림이 온다.
     - 권한 허용 문구 시스템적으로 최초 한번만 뜬다
     - 허용안된경우 애플 설정으로 직접 유도하는 코드 구성해야함.
     
     - 기본적으로 알림은 포그라운드에서 수신되지않음.
     - 로컬알림에서는 60초이상 반복가능 / 개수제한 64개까지 /커스텀 사운드 30초
     
     
     1.뱃지제거 ->언제제거해야될까?
     2.노티제거 -> 노티의유효기간은? -> 카카오톡 (알림누르면 모든푸쉬가 날라감) -> 언제삭제해주는게맞을까?
     3.포그라운드수신 -> 델리게이트 메서드로 해결
     
     
     //중후반부에 실시
     4. 노티앱실행이 기본인데 특정 노티를 클릭할떄 특정화면을 가고싶다면?
     5. 포그라운드 수신, 특정화면에서는 안받고 특정조건에대해서만 수신하고싶다면?
     
    */
    
    
    func sendNotification(){
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "다마고치 키워보세요"
        notificationContent.subtitle = "오늘의 행운의숫자 \(Int.random(in: 1...100))"
        notificationContent.body = "저는 따끔따끔 다마고치입니다."
        notificationContent.badge = 40
        
        // 언제 보낼건가? 1. 시간간격,2.캘린더,3.위치에 따라 설정가능
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval:60, repeats: true) // 5초뒤에 보내겟다. false하면 한번만 보냄 true하면 여러번보내
//        var dateComponent = DateComponents()
//        dateComponent.minute = 15
//
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
        
        
        // 알림요청
        
        // 만약 알림관리할 필요 x - > 알림 클릭하면 앱을켜주는정도
        // 만약 알림 관리할필요 o -> +1해주거나,고유이름 등
        // identifier: 알림이 스택으로쌓일지 아닐지 정함
        // 12개 >
        let request = UNNotificationRequest(identifier: "\(Date())", content: notificationContent, trigger: trigger) //identifier: "\(Date())"
        notificationCenter.add(request) //등록시 시간,날짜 계속체크 앱이꺼져도
        
        
        
    }
    
    

    
    
    
    
    
    
   

}
