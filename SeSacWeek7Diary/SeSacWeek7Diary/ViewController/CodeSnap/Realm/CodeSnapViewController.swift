//
//  CodeSnapViewController.swift
//  SeSacWeek7Diary
//
//  Created by useok on 2022/08/17.
//

import UIKit
import SnapKit
import RealmSwift

class CodeSnapViewController: UIViewController {
    
    let localRealm = try! Realm() // reaelm 테이블의 데이를 CRUD할떄 , Realm테이블 경로에 접근
    
    //이미지뷰 
    let photoImageView : UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.contentMode = .scaleAspectFit
        return view
    }()
    let imageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Button", for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layer.borderWidth = 2
        button.setTitleColor(.blue, for: .normal)
        button.layer.borderColor = UIColor.blue.cgColor
        return button
    }()
    
    //이미지 제목
    let titleTextField : UITextField = {
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
    // Realm 실습용 샘플버튼
    let sampleButton: UIButton = {
        let button = UIButton()
        button.setTitle("sample", for: .normal)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.layer.borderWidth = 2
        button.layer.backgroundColor = UIColor.red.cgColor
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        sampleButton.addTarget(self, action: #selector(sampleButtonClicked), for: .touchUpInside)
        imageButton.addTarget(self, action: #selector(buttonclciekd), for: .touchUpInside)
        print("Realm is located at:", localRealm.configuration.fileURL!)
    }
    func configureUI() {
        //for - in  vs  foreach(클로저를 파라미터로받음)
        let viewList =  [photoImageView,imageButton,titleTextField,dateTextField,contentTextField,sampleButton]
       viewList.forEach {
            view.addSubview($0)
        }
        // sampleButton 샘플버튼
        sampleButton.snp.makeConstraints {
            $0.top.equalTo(photoImageView.snp.top)
            $0.trailing.equalTo(photoImageView.snp.trailing)
            $0.height.equalTo(imageButton.snp.height)
        }

        
        //이미지뷰 안에 버튼
        imageButton.snp.makeConstraints {
            $0.trailing.equalTo(photoImageView.snp.trailing).inset(30)
            $0.bottom.equalTo(photoImageView.snp.bottom).inset(30)
            $0.height.equalTo(photoImageView.snp.height).multipliedBy(0.25)
        }
        //이미지 뷰
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(view).multipliedBy(0.3) //뷰높이 기준에서 * 0.3된거
        }
        //제목입력 텍스트필드
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(20)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50) //높이
        }
        //날짜입력 텏흐트필드
        dateTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50) //높이
        }
        //
        contentTextField.snp.makeConstraints { make in
            make.top.equalTo(dateTextField.snp.bottom).offset(20)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
//        photoImageView.translatesAutoresizingMaskIntoConstraints = false //이게 snapkit 내부적으로 구현되있어서 안써도됨.
    }
    
    @objc func buttonclciekd() {
        let task = Userdiary(diaryTitle: "\(Int.random(in: 1...1000))오늘의일기", diaryContent: "일기내용", diaryDate: Date(), regdate: Date(), photo: nil)  // record

        try! localRealm.write {
            localRealm.add(task) // record 생성
            print("Realm Succeed")
//            dismiss(animated: true)
        }
        
        let sb = UIStoryboard(name: "WalkThrough", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: DiaryViewController.reuseIdentifier) as? DiaryViewController else {return}
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func sampleButtonClicked() {
        let sb = UIStoryboard(name: "WalkThrough", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: HomeViewController.reuseIdentifier) as? HomeViewController else {return}
        self.navigationController?.pushViewController(vc, animated: true)
    }


}
