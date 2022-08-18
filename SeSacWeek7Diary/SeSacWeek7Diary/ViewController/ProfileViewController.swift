//
//  ProfileViewController.swift
//  SeSacWeek7Diary
//
//  Created by useok on 2022/08/18.
//

import UIKit
import SnapKit
class ProfileViewController: UIViewController {
    let saveButton: UIButton = {
        let view = UIButton()
        view.setTitle("저장", for: .normal)
        view.tintColor = .black
        return view
    }()
    let nameTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "이름입력하세요"
        view.backgroundColor = .brown
        view.textColor = .white
        return view
    }()
    var saveButtonActionHandler: (()-> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        configure()
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
        saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
    }
    @objc func saveButtonClicked() {
        //값전달 기능 실행 -> 클로저 구문 활용
        saveButtonActionHandler?()
        //화면 dismiss
        dismiss(animated: true)
    }
    

}
