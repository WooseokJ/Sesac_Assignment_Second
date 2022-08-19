//
//  WriteViewController.swift
//  SeSacWeek7Diary
//
//  Created by useok on 2022/08/19.
//


import UIKit
import Foundation

class WriteViewController: UIViewController { //원래는 BaseViewController이거 상속
   
    var mainview = WriteView() //let도가능
    
    // viewdidload보다 이게더 먼저호출
    override func loadView() { //super.loadView 호출 x
        self.view = mainview //view -> rootview 를 뜻함.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ss()
        view.backgroundColor = .red
//        mainview.titleTextField.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>) // viewcontroller에서는 기능같은것만.
    }
    
    func ss() {// 상속받은거 오버라이딩

        mainview.titleTextField.addTarget(self, action: #selector(titleTextFieldClicked(_ :)), for: .editingDidEndOnExit)
    }
    func aa() { //상속받은거 오버라이딩   원래는 override func aa()  // baseViewController에 있음.

    }
    
    
    @objc func titleTextFieldClicked(_ textField: UITextField) { //textField = titleTextField 와 동일
        guard let text = textField.text, text.count > 0 else {
            showAlertMessage(title: "제목입력해줘", butoon: "확인")
            return
        }
    }
    
    func showAlertMessage(title: String, butoon: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: butoon, style: .cancel)
        alert.addAction(ok)
        present(alert,animated: true)
    }
}


