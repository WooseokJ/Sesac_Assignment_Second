import UIKit

extension UIViewController {
    open func testOpen() {}
    //얼럿띄울거야  , public을 붙이면 다른프로젝트에서도 사용가능
    public func showSesacAlert(title: String, message: String,buttonTitle: String, buttonAction: @escaping ( (UIAlertAction)-> Void) ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: buttonTitle, style: .default, handler: buttonAction)
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert,animated: true)
    }
    internal func testInternal() {}
    fileprivate func testFilePrivate() {}
    private func testPrivate() {}
    
    
}
