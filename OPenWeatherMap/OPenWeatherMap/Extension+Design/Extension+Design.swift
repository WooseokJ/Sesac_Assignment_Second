//
//  Extension+Design.swift
//  OPenWeatherMap
//
//  Created by useok on 2022/08/15.
//

import Foundation
import UIKit

extension UILabel {
    //라벨 디자인
    func labelDesign(_ label: UILabel) {
        label.text = ""
    }
}

extension UIButton {
    func buttonDesign(_ button: UIButton,imageName: String) {
        button.setImage(UIImage(systemName: imageName), for: .normal)
    }
}

extension UIView {
    func backUIViewDesign(_ view: UIView) {
        view.backgroundColor = .brown
    }
}
