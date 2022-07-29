import UIKit
@main
class AppDelegate: UIResponder, UIApplicationDelegate ,UNUserNotificationCenterDelegate{



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 2. 노티제거
         // 알람앱,미리알림,스케줄,할일목록 -> 하루전 알림 30분전알림.
         UNUserNotificationCenter.current().removeAllDeliveredNotifications()
         
         UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list,.banner,.badge,.sound]) // alert이 list,banner로 나뉘엇다(io14이상부터)
    }

    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0,*)

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    @available(iOS 13.0,*)

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
       
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print("앱이꺼짐")
    }

}

