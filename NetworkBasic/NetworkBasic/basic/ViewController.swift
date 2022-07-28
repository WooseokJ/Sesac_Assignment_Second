//
//  ViewController.swift
//  NetworkBasic
//
//  Created by useok on 2022/07/27.
//

import UIKit

class ViewController: UIViewController ,ViewPresentableProtocol {
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    // 대신 구현하는 클래스,구조체,열거형,익스텐션은 var를못쓰고 let만사용가능
    static let identifier: String = "ViewController"
    var navigationTitleString: String = "대장님 다마고치" // 저장프로퍼티로사용
    /* 위와동일
    var navigationTitleString: String { // 저장연산프로퍼티
        get{
            return "대장님 다마고치"
        }
        set{
            navigationTitleString = newValue
        }
    }
    */
    var backgroundColor: UIColor = .blue // 저장프로퍼티로사용

        
            
        
    
    
    func configureView() {
        navigationTitleString = "고래밥님 다마고치" //set사용
        backgroundColor = .red // get밖에안햇지만(읽기전용) 값변경가능
        
        view.backgroundColor = backgroundColor //get 사용
        title = navigationTitleString // get 사용
    }
    

    

    
}

