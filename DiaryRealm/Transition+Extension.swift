
import UIKit

extension UIViewController {
    
    enum TransitionStyle {
        case present // 네비게이션 없이 present
        case presentNavigation // 네비게이션 임베드 present
        case presentFullNavigation // 네비게이션 + 풀스크린
        case push
    }
    
    func transition<T: UIViewController>(_ viewController: T, transitionStyle: TransitionStyle = .present) {
        
        switch transitionStyle {
        case .present:
            self.present(viewController, animated: true)
        case .presentNavigation:
            let nav = UINavigationController(rootViewController: viewController)
            self.present(nav, animated: true)
        case .push:
            self.navigationController?.pushViewController(viewController, animated: true)
        case .presentFullNavigation:
            let nav = UINavigationController(rootViewController: viewController)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        }
    }
    
}
