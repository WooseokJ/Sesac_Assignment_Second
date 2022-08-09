

import UIKit

// @ 붙은것들을 swift Attribute(속성)라고 부름 ex) @objc, @escaping, @IBDesignable, @IBInspectable, @avaiable, @discardableResult etc..

/// @IBDesignable 인터페이스 빌더 컴파일시점에서 실시간으로 객체속성 확인가능
@IBDesignable class SeSacButton: UIButton {

// @IBInspectable  // 인스팩터영역(스토리보드)의 속성에서 보임,  실제 기능을넣어주진않음(그래서 @IBDesignable 사용)
    @IBInspectable var cornerRadius : CGFloat { // core graphic
        get {return layer.cornerRadius}
        set {layer.cornerRadius = newValue}
    }
    @IBInspectable var borderWidth : CGFloat {
        get {return layer.borderWidth}
        set {layer.borderWidth = newValue}
    }
    @IBInspectable var borderColor : UIColor {
        get {return UIColor(cgColor: layer.borderColor!)}
        set {layer.borderColor = newValue.cgColor}
    }

}
