
import Foundation

//WebViewController
open class OpenWebView { //open이되면 오버라이딩해서 사용할수있다.

    public enum TransitionStyle {
        case present
        case push
    }

    public static func presentWebViewController(_ viewController: UIViewController, url: String, transitionStyle: TransitionStyle) {
        
        let vc = WebViewController()
        vc.url = url //아래 url 가져온거
        
        switch transitionStyle {
        case .present:
            viewController.present(vc, animated: true)
        case .push:
            viewController.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

import WebKit

class WebViewController: UIViewController {

    private var webView: WKWebView! // priavte var webView 하면 이클래스 내에서만 쓰겟다.
    
    var url: String = "https://www.apple.com"
    
    override func loadView() {
//        super.loadView() //이건 호출안하는이유잇음.
        let configuration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: configuration)
        view = webView
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = URL(string: url) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
        
    }
    

}
