//
//  BaseView.swift
//  DiaryRealm
//
//  Created by useok on 2022/08/25.
//
import UIKit
import SnapKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configureUI() {
        self.backgroundColor = Constants.BaseColor.background
    }
    
    func setConstraints() {}
}
