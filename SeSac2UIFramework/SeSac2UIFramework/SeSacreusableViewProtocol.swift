
import Foundation
import UIKit

//Reusable
public protocol ReusableViewProtocol { // open은 사용못함
    static var reuseIdentifier: String { get }
}

extension UIViewController: ReusableViewProtocol {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableViewProtocol {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell : ReusableViewProtocol {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}
