//
//  CodeViewController.swift
//  SeSacWeek7Diary
//
//  Created by useok on 2022/08/17.
//

import UIKit
/**
 공통
 1. 뷰객체 프로퍼티선언,클래스의 인스턴스생성
 2.명시적으로 로드뷰 추가
 3. 크기.위치 및 속성정의
 -> frame 기반 한계( 아이폰5)
 -> autoresizingMast, autolayout 등장
 -> NsLayoutConstraints (이거로 코드로 ui구성가능해짐)
 */
class CodeViewController: UIViewController {
    //MARK: 1. 뷰객체 프로퍼티선언,클래스의 인스턴스생성
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let signButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //MARK: 2.명시적으로 로드뷰 추가
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signButton)
        
        //MARK: 3. 크기.위치및 속성정의(frame기반)   순서1
        emailTextField.frame = CGRect(x: 50, y: 50, width: UIScreen.main.bounds.width - 100, height: 50)
        emailTextField.borderStyle = .line
        emailTextField.backgroundColor = .lightGray
        
        //MARK: NSlayoutconstraints(이것을 코드를 쓰진않아) 순서2
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false // autoresizing기반으로 하는건 false로 설정
        passwordTextField.backgroundColor = .lightGray
        // top
//        let top = NSLayoutConstraint(item: passwordTextField, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 100)
//        top.isActive = true
//        // leading
//        NSLayoutConstraint(item: passwordTextField, attribute: .leading, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 50).isActive = true// isActive는 레이아웃활성화
//        // trailing
//        NSLayoutConstraint(item: passwordTextField, attribute: .trailing, relatedBy: .equal, toItem: emailTextField, attribute: .trailing, multiplier: 1, constant: -50).isActive = true
//        // height
//        NSLayoutConstraint(item: passwordTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 60).isActive = true
        
        //MARK: NSlayoutconstraints addConstraints 순서3
        //top
        let top = NSLayoutConstraint(item: passwordTextField, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 100)
        // leading
        let leading = NSLayoutConstraint(item: passwordTextField, attribute: .leading, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 50)
        // trailing
        let trailing = NSLayoutConstraint(item: passwordTextField, attribute: .trailing, relatedBy: .equal, toItem: emailTextField, attribute: .trailing, multiplier: 1, constant: -50)
        // height
        let height = NSLayoutConstraint(item: passwordTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 60)
        view.addConstraints([top, leading, trailing, height])
        
        //MARK: NSlayoutAnchor 순서4
        signButton.translatesAutoresizingMaskIntoConstraints = false
        signButton.backgroundColor = .orange
        NSLayoutConstraint.activate([
            signButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signButton.widthAnchor.constraint(equalToConstant: 300),
            signButton.heightAnchor.constraint(equalToConstant: 50),
            signButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        //화면전환하기
//        let vc = CodeViewController()
//        present(vc,animated: true)
//
//    }

}
