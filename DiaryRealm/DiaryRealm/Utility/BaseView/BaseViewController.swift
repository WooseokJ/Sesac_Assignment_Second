//
//  BaseViewController.swift
//  DiaryRealm
//
//  Created by useok on 2022/08/25.
//
import UIKit

class BaseViewController: UIViewController { //final붙이면 상속이안되므로 붙이면안됨.

    override func viewDidLoad() {
        super.viewDidLoad() 
        configure()
        setConstraints()
    }
    
    func configure() {
        
    }
    
    func setConstraints() {
        
    }
    
    func showAlertMessage(title: String, button: String = "확인") {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: button, style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
}
