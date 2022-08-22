//
//  SceneDelegate.swift
//  SeSacWeek7Diary
//
//  Created by useok on 2022/08/16.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // 첫화면 네비게이션 연결
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let sb = UIStoryboard(name: "WalkThrough", bundle: nil)
        let vc2 = sb.instantiateViewController(withIdentifier: CodeSnapViewController.reuseIdentifier) as! CodeSnapViewController
        let nav = UINavigationController(rootViewController: vc2)
        window?.rootViewController = nav
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
       
    }

    func sceneWillResignActive(_ scene: UIScene) {
       
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
       
    }


}

