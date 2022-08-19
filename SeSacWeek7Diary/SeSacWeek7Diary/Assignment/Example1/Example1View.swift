//
//  Example1Model.swift
//  SeSacWeek7Diary
//
//  Created by useok on 2022/08/20.
//

import Foundation
import UIKit

class Example1View: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstrains() 
    }
    
    required init?(coder: NSCoder) {
//        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {}
    func setConstrains() {}
    
    
    
}
