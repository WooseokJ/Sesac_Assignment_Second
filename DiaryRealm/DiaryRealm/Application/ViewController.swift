////
////  ViewController.swift
////  DiaryRealm
////
////  Created by useok on 2022/08/25.
////
//
//import UIKit
//import Zip
//
class ViewController: BaseViewController {
//    
    override func viewDidLoad() {
        super.viewDidLoad()
//        DispatchQueue.main.asyncAfter(deadline: .now()+2) { //2 초뒤 실행
//            self.backupButtonClicked()
//        }
        view.backgroundColor = .blue
    }
//    
//    
//    func backupButtonClicked() {
//        
//        var urlPaths = [URL]() // 빈배열 타입이 URL
//        
//        
//        //  도큐먼트 위치에 백업파일 확인
//        guard let path = documentDirectoryPath() else { // path는 도큐먼트 경로
//            showAlertMessage(title: "documnet 위치에 오류가있음")
//            return
//        }
//        let realFile = path.appendingPathComponent("default.realm") // 도큐먼트경로/default.realm
//        guard FileManager.default.fileExists(atPath: realFile.path) else { // 경로에 파일이 존재하는지 확인
//            showAlertMessage(title: "백업할 파일이 없습니다.")
//            return
//        }
//        let backUpFileURL = URL(string: realFile.path)! //realFile와 같은경로라서 backUpFileURL과 동일
//        urlPaths.append(backUpFileURL) //
//        // 백업파일압축: URL   (https://github.com/marmelroy/Zip.git)
//        do {
//            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "sesacDiary") // Zip
//            print("Archive location: \(zipFilePath)")
//            // activityviewController
//            showActivityViewController()
//        } catch {
//            showAlertMessage(title: "압축실패")
//        }
//
//    }
//    // activityviewController 성공할떄
//    func showActivityViewController() {
//        guard let path = documentDirectoryPath() else {
//            showAlertMessage(title: "도큐먼트 위치 ")
//            return
//        }
//        let backupFileURL = path.appendingPathComponent("sesacDiary.zip")
//        
//        let vc = UIActivityViewController(activityItems: [backupFileURL], applicationActivities: [] ) //activityItems: 어떤거보낼래?
//        self.present(vc,animated: true)
//    }
//    
//    func restoreButtonClicked() {
//        
//    }
//    
//    
}
//
