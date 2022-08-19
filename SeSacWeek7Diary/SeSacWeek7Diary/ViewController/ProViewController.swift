//
//  ProViewController.swift
//  SeSacWeek7Diary
//
//  Created by useok on 2022/08/18.
//

import UIKit
import SnapKit


class ProViewController: UIViewController {

    let nameButton: UIButton = {
        let view = UIButton()
        view.setTitle("닉네임", for: .normal)
        view.backgroundColor = .black
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
    }
    
   
    
    func configure() {
        view.addSubview(nameButton)
        nameButton.snp.makeConstraints { make in
            make.width.height.equalTo(200)
            make.center.equalTo(view)
        }
        nameButton.addTarget(self, action: #selector(nameButtonClicked), for: .touchUpInside)
    }
    @objc func nameButtonClicked() {
        
        let vc = WriteViewController()
        present(vc, animated: true)
        
        
//        NotificationCenter.default.post(name: NSNotification.Name("TEST"), object: nil , userInfo: ["name": Int.random(in: 1...100), "value": 123456] )
//        let vc = ProfileViewController()
//        vc.saveButtonActionHandler = { name in
//              self.nameButton.setTitle(name, for: .normal)   // name은 vc.nameTextField.text의미
//        }
//        present(vc,animated: true)
    }
    

}
