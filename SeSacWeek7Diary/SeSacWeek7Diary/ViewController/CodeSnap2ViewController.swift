//
//  CodeSnap2ViewController.swift
//  SeSacWeek7Diary
//
//  Created by useok on 2022/08/17.
//

import UIKit
import SnapKit

class CodeSnap2ViewController: UIViewController {

    let blackView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    let redView : UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    let yellowView : UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [redView,blackView].forEach { // [blackview,redview] 와 다른결과가나옴.
            view.addSubview($0)
        }
        redView.addSubview(yellowView)
       
        redView.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(200)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalTo(view)
        }
        blackView.snp.makeConstraints { make in
//            make.edges.equalTo(redView).offset(50) //redView와 동일한크기 , offset은 x,y 둘다 50만큼 이동
            make.edges.equalTo(redView).inset(50)
        }
        yellowView.snp.makeConstraints { make in
            make.edges.equalTo(redView).inset(10)
        }
    }
    


 

}
