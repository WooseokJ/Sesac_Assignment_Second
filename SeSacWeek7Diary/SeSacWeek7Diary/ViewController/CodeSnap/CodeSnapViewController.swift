//
//  CodeSnapViewController.swift
//  SeSacWeek7Diary
//
//  Created by useok on 2022/08/17.
//

import UIKit
import SnapKit

class CodeSnapViewController: UIViewController {

    //이미지뷰
    let photoImageView : UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.contentMode = .scaleAspectFit
        return view
    }()
    //이미지 제목
    let titleTextField : UITextField = {
        print("titletextField")
        let view = UITextField()
        view.borderStyle = .none
        view.layer.borderColor = UIColor.blue.cgColor
        view.layer.borderWidth = 1
        view.placeholder = "제목을 입력해줘"
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 15)
        return view
    }()
    //날짜
    let dateTextField : UITextField={
        let view = UITextField()
        view.borderStyle = .none
        view.layer.borderColor = UIColor.blue.cgColor
        view.layer.borderWidth = 1
        view.placeholder = "날짜를 입력해줘"
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 15)
        return view
    }()
    //내용
    let contentTextField : UITextField = {
        let view = UITextField()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        configureUI()
    }
    func configureUI() {
        //for - in  vs  foreach(클로저를 파라미터로받음)
        let viewList =  [photoImageView,titleTextField,dateTextField,contentTextField]
       viewList.forEach {
            view.addSubview($0)
        }
 
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(view).multipliedBy(0.3) //뷰높이 기준에서 * 0.3된거
        }
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(20)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50) //높이
        }
        dateTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50) //높이
        }
        contentTextField.snp.makeConstraints { make in
            make.top.equalTo(dateTextField.snp.bottom).offset(20)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        
//        photoImageView.translatesAutoresizingMaskIntoConstraints = false //이게 snapkit 내부적으로 구현되있어서 안써도됨.
    }
    



}
