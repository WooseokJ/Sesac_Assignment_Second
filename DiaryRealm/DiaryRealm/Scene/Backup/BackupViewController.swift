

import UIKit
import Zip

class BackupViewController: BaseViewController {

    let mainview = BackupView()
    
    override func loadView() {
        super.view = mainview
    }
    
    let tableView: UITableView = {
        let view = UITableView()
        //테이블뷰 높이
        view.rowHeight = 100
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDocumentZipFile() //확인용 무시
        
//        DispatchQueue.main.asyncAfter(deadline: .now()+2) { //2 초뒤 실행
//            self.backupButtonClicked()
//        }
        
        view.backgroundColor = .black
        mainview.backupButton.addTarget(self, action: #selector(backupButtonClicked), for: .touchUpInside)
        mainview.storedButton.addTarget(self, action: #selector(storedButtonClicked), for: .touchUpInside)
        
        mainview.tableView.delegate = self
        mainview.tableView.dataSource = self
        mainview.tableView.register(BackupTableViewCell.self, forCellReuseIdentifier: "BackupTableViewCell")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(xmarkClicked))

    }

    //복구버튼 클릭시
    @objc func storedButtonClicked() {
        restoreButtonClicked()
    }
    @objc func xmarkClicked() {
        dismiss(animated: true)
    }

    //MARK: 백업
    @objc func backupButtonClicked() {
        backupButtonClickedStart()
    }
    
    func backupButtonClickedStart() {
        
        var urlPaths = [URL]() // 빈배열 타입이 URL
        
        
        //  도큐먼트 위치에 백업파일 확인
        guard let path = documentDirectoryPath() else { // path는 도큐먼트 경로
            showAlertMessage(title: "documnet 위치에 오류가있음")
            return
        }
        let realFile = path.appendingPathComponent("default.realm") // 도큐먼트경로/default.realm
        guard FileManager.default.fileExists(atPath: realFile.path) else { // 경로에 파일이 존재하는지 확인
            showAlertMessage(title: "백업할 파일이 없습니다.")
            return
        }
        let backUpFileURL = URL(string: realFile.path)! //realFile와 같은경로라서 backUpFileURL과 동일
        urlPaths.append(backUpFileURL) //
        // 백업파일압축: URL   (https://github.com/marmelroy/Zip.git)
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "sesacDiary") // Zip
            print("Archive location: \(zipFilePath)")
            // activityviewController
            showActivityViewController()
        } catch {
            showAlertMessage(title: "압축실패")
        }

    }
    // activityviewController 성공할떄
    func showActivityViewController() {
        guard let path = documentDirectoryPath() else {
            showAlertMessage(title: "도큐먼트 위치 ")
            return
        }
        let backupFileURL = path.appendingPathComponent("sesacDiary.zip")
        
        let vc = UIActivityViewController(activityItems: [backupFileURL], applicationActivities: [] ) //activityItems: 어떤거보낼래?
        self.present(vc,animated: true)
    }
    //MARK: 복구
    func restoreButtonClicked() {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.archive], asCopy: true) // 반드시 파일앱에 저장해놔야함 ascopy:     UIDocumentPickerViewController는 문서선택시 어떻게해줄거냐?
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        self.present(documentPicker,animated: true)
    }
    
}

extension BackupViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BackupTableViewCell.reuseIdentifier) as? BackupTableViewCell else {return UITableViewCell()}
        cell.backgroundColor = .white
        cell.titleLabel.text = "백업\(indexPath.row)"
        return cell
    }
    // row 셀 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}


extension BackupViewController: UIDocumentPickerDelegate{
    // 취소누른경우
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("도큐먼트피터 닫았습니다.")
    }
    // 경로 선택시
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        guard let selectedFieldURL = urls.first else { //압축파일(파일앱의 zip) 선택한파일이 있는지 확인   ~fileapp/foder
            showAlertMessage(title: "선택한 파일 찾을수없음")
            return
        }
        print("selectedFieldURL",selectedFieldURL)
        guard let path = documentDirectoryPath() else { // 보낼 위치(나의앱 도큐먼트)가 맞는지 // path는 파일에대한 경로      ~/document
            showAlertMessage(title: "도큐먼트 위치 오류있음")
            return
        }
        print("path",path)
        let sandboxFileURL = path.appendingPathComponent(selectedFieldURL.lastPathComponent) //selectedFieldURL.lastPathComponent 는 sesacDiary.zip      선택한 압축파일의 최종경로 ~fileapp/foder/sesacDiary.zip
        
        print("sandboxFileURL",sandboxFileURL)
        
        // sandboxFileURL 에 이미 파일이 있는경우
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {  // 파일앱에 복구파일있는경우
            let fileURL = path.appendingPathComponent("sesacDiary.zip")   // ~/document/sesacDiary.zip
            do {
                try Zip.unzipFile(fileURL, destination: path , overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                    self.showAlertMessage(title: "복구가완료되얷습니다.")
                    
                }) //overwrite은 덮어씌우기
            } catch {
                showAlertMessage(title: "압축해제실패")
            }
        } else {
            do {
               //파일 앱 zip -> 도큐먼트 폴더에 복사
                try FileManager.default.copyItem(at: selectedFieldURL, to: sandboxFileURL)
                
                let fileURL = path.appendingPathComponent("sesacDiary.zip") //  ~fileapp/foder/sesacDiary.zip
                
                try Zip.unzipFile(fileURL, destination: path , overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                    self.showAlertMessage(title: "복구가완료되얷습니다.")
                    self.inital()
             
                }) //overwrite은 덮어씌우기
                
            } catch {
                showAlertMessage(title: "압축해제 실패")
            }
        }
    }
    func inital() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
      let sceneDelegate = windowScene?.delegate as? SceneDelegate
      let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: HomeViewController.reuseIdentifier) as! HomeViewController
      let nav = UINavigationController(rootViewController: vc)
      sceneDelegate?.window?.rootViewController = nav
      sceneDelegate?.window?.makeKeyAndVisible()
    }
}
