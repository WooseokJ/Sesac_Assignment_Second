//
//  Example3ViewController.swift
//  SeSacWeek7Diary
//
//  Created by useok on 2022/08/19.
//

import UIKit

class Example3ViewController: UIViewController {

    //백그라운드
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.6
        return view
    }()
    // 이미지 뷰
    let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "star")
        image.backgroundColor = .yellow
        return image
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    func configure() {
        //
        [backgroundView].forEach{
            view.addSubview($0)
        }
        //
        backgroundView.snp.makeConstraints {
            $0.top.equalTo(0)
            $0.bottom.equalTo(0)
            $0.leading.equalTo(0)
            $0.trailing.equalTo(0)
        }
        
    }
    


}
