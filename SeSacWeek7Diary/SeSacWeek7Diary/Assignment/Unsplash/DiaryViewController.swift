//
//  DiaryViewController.swift
//  SeSacWeek7Diary
//
//  Created by useok on 2022/08/21.
//

import UIKit
import RealmSwift

class DiaryViewController: UIViewController {

    let mainview = DiaryView()
        
    override func loadView() {
        super.view = mainview
    }
    
            
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(selectClicked))

    }
    // Re
    @objc func selectClicked() {
                
    }
    


}
