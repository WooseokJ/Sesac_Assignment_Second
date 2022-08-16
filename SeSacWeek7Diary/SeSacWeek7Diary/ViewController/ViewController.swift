import UIKit
import SeSac2UIFramework

class ViewController: UIViewController {

    // 사각형 네개 -> counterparts -> viewController(interface)
    var name = "고래밥" // internal var name 와 동일
    private var age = 22
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    // 오버라이딩
    // override func testOpen() {<#code#>}
    override func viewDidAppear(_ animated: Bool) {
        //MARK: open, public은 불러올수있지만 internal,private,fileprivate는 불러올수없음(해당 프로젝트에서만 사용가능)
        testOpen()
        
        //MARK: 1.앨럿창
//        showSesacAlert(title: "테스트앨럿", message: "테스트메세지", buttonTitle: "변경") { _ in
//            self.view.backgroundColor = .lightGray
//        }
        
        //MARK: 2.ActivityViewController ( 공유하기)
//        let image = UIImage(systemName: "star.fill")!
//        let shareURL = "https://www.apple.com"
//        let text = "WWDC what's New!!"
//        sesacShowActivityViewController(shareImage: image, shareURL: shareURL, shareText: text)
        
        // MARK: 3.present로 네이버 띄우기
//        let web = OpenWebView() //이방법은 오류가 나와서 presentWebViewController를 static으로 바꿈
        OpenWebView.presentWebViewController(self, url: "https://naver.com", transitionStyle: .present)
        
        
    }


}

