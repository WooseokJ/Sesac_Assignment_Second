//
//  UIViewController+Extension.swift
//  SeSacWeek7Diary
//
//  Created by useok on 2022/08/18.
//

import Foundation
import UIKit

extension UIViewController {
    func transitionViewController<T: UIViewController>(storyBoard: String, viewController vc: T) {
        let sb = UIStoryboard(name: storyBoard, bundle: nil)
        guard let controller = sb.instantiateViewController(withIdentifier: String(describing: vc))as? T else {return}
        self.present(controller,animated: true)
    }
}
