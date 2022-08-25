
import UIKit
import RealmSwift //Realm 1.



class WriteViewController: BaseViewController {

    let mainView = WriteView()
    let localRealm = try! Realm() //Realm 2. Realm 테이블에 데이터를 CRUD할 때, Realm 테이블 경로에 접근
    
    override func loadView() {
        self.view = mainView
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        print("Realm is located at:", localRealm.configuration.fileURL!)
    }
    
    override func configure() {
        mainView.searchImageButton.addTarget(self, action: #selector(selectImageButtonClicked), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(saveButtonClicked))
    }
    
    @objc func closeButtonClicked() {
        dismiss(animated: true)
    }
    
    
    // Realm + 이미지 도큐먼트 저장
    @objc func saveButtonClicked() {
        guard let title = mainView.titleTextField.text else {
            showAlertMessage(title: "제목을 입력해주세요", button: "확인")
            return
        }
        let task = UserDiary(diaryTitle: title, diaryContent: "\(mainView.contentTextView.text!)", diaryDate: Date(), regdate: Date(), photo: nil)
        do {
            try localRealm.write {
                localRealm.add(task)
            }
        } catch let error {
            print(error)
        }
        if let image = mainView.userImageView.image {
            saveImageToDocument(fileName: "\(task.objectId).jpg", image: image)
        }
        dismiss(animated: true)
    }
      
    @objc func selectImageButtonClicked() {
        let vc = SearchImageViewController()
        vc.delegate = self // self는 WriteViewController인스턴스 전달
        transition(vc, transitionStyle: .presentNavigation)
    }
}

protocol SelectImageDelegate {
    func sendImageData(image: UIImage)
}

extension WriteViewController: SelectImageDelegate {
    // 언제 실행되면 될까? -> 선택버튼 누를때
    func sendImageData(image: UIImage) {
        mainView.userImageView.image = image
        print(#function)
    }

}
