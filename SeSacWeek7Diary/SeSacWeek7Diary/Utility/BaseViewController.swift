
//  BaseViewController.swift

import UIKit
import SnapKit


class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setConstrains()
        view.backgroundColor = .systemGray2
    }
    func configure() {}
    
    func setConstrains() { }
    
    func showAlertMessage(title: String, butoon: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: butoon, style: .cancel)
        alert.addAction(ok)
        present(alert,animated: true)
    }
    
    
    
    
    
}

