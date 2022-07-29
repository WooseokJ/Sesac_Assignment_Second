//
//  SceneDelegate.swift
//  NetworkBasic
//
//  Created by useok on 2022/07/27.
//

import UIKit
@available(iOS 13.0,*)

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       // 2. 노티제거
        // 알람앱,미리알림,스케줄,할일목록 -> 하루전 알림 30분전알림.
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        

        
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
     
    }

    func sceneDidBecomeActive(_ scene: UIScene) { //
        
        // Badge 제거
        UIApplication.shared.applicationIconBadgeNumber = 0 
        
        
    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) { //포그라운드
        
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }


}

