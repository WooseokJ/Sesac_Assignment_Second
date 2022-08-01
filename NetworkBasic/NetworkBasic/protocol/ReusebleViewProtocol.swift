//
//  ReusebleViewProtocol.swift
//  NetworkBasic
//
//  Created by useok on 2022/08/01.
//

import Foundation
import UIKit

protocol ReusebleViewProtocol{
    static var reuseIdentifier: String { get } //변경되면안됨.
}

extension UIViewController: ReusebleViewProtocol{
    static var reuseIdentifier: String { //연산프로퍼티( extension은 저장프로퍼티 사용못함)
        return String(describing: self) //self: UIViewController
    }
}

extension UITableViewCell: ReusebleViewProtocol{ // 이거쓰면 identifier = UITableViewCell를 편하게쓸수있음.
    static var reuseIdentifier: String{
        return String(describing: self) //self: UITableViewCell
    }
}
