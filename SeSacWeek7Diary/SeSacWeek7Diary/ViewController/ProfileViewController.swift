//
//  ProfileViewController.swift
//  SeSacWeek7Diary
//
//  Created by useok on 2022/08/18.
//

import UIKit
import SnapKit


extension NSNotification.Name {
    static let saveButton = NSNotification.Name("saveButtonNotification")
}

class ProfileViewController: UIViewController {
    let saveButton: UIButton = {
        let view = UIButton()
        view.setTitle("저장", for: .normal)
        view.tintColor = .black
        view.backgroundColor = .black
        return view
    }()
    let nameTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "이름입력하세요"
        view.backgroundColor = .lightGray
        view.textColor = .white
        return view
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        configure()
        saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(saveButtonNotificationObserver(notification:)), name:NSNotification.Name.saveButton , object: nil)
        
    }
    
    @objc func saveButtonNotificationObserver(notification: NSNotification) {
        print(#function)
        if let name = notification.userInfo?["name"] as? String {
            print(name)
            self.nameTextField.text = name
        }else {
            
        }
    }
    
    func configure() {
        [saveButton,nameTextField].forEach {
            view.addSubview($0)
        }
        nameTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).inset(50)
            make.top.equalTo(50)
            make.height.equalTo(50)
        }
        
        saveButton.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.center.equalTo(view)
        }
    
    }
        var saveButtonActionHandler: ( (String)-> () )? //값전달 준비
    
    @objc func saveButtonClicked() {
        //값전달 기능 실행 -> 1. 클로저 구문 활용
        saveButtonActionHandler?(nameTextField.text!)  // 값전달 실행
        
        // 2. 값전달실행 -> notification  Userdefalut와 다른건 notification은 사용할떄만 저장됨.
        NotificationCenter.default.post(name: NSNotification.Name("saveButtonNotification"), object: nil , userInfo: ["name": nameTextField.text!, "value": 123456] )
        
        //화면 dismiss
        dismiss(animated: true)
    }

    

}
