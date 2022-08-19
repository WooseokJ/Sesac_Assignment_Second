//
//  BlackRediusTextField.swift
//  SeSacWeek7Diary
//
//  Created by useok on 2022/08/19.
//

import Foundation
import UIKit

class BlackRediusTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.backgroundColor = .clear
        self.textAlignment = .center
        self.borderStyle = .none
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
}
