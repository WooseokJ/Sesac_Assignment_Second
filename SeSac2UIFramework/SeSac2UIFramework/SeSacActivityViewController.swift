

import Foundation
import UIKit

extension UIViewController {
    
    //UIActivityViewController
    public func sesacShowActivityViewController(shareImage: UIImage, shareURL: String, shareText: String) {
        
        let viewController = UIActivityViewController(activityItems: [shareImage, shareURL, shareText], applicationActivities: nil)
        viewController.excludedActivityTypes = [.mail,.assignToContact] //메일,연락처에지정 은 제외
        self.present(viewController, animated: true)
    }
}
