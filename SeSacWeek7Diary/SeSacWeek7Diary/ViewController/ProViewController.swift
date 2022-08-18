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
        view.tintColor = .black
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
        let vc = ProfileViewController()
        vc.saveButtonActionHandler = {
            self.nameButton.setTitle(vc.nameTextField.text, for: .normal)
        }
        
        present(vc,animated: true)
    }
    

}
