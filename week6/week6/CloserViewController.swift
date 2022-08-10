import UIKit

class CloserViewController: UIViewController {

    @IBOutlet weak var purpleView: UIView!
    @IBOutlet weak var cardView: cardView!
    // frame based
    var sampleButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // 오토리사이징을 오토레이아웃 제약조건처럼 설정해주는 기느이 내부적으로 구현되있음. 이 기능은 디폴트가 true 허자먼
        // 오토레이아웃을 지정해주면 오토리사이징을 안쓰겟다는 의미로 flase 상태가 내부적으로 변경 오토리사이징+오토레이아웃 = 충돌 코드기반 UI > true
        // 인터페이스 빌더 기반 레이아웃 ui -> false
//        print(sampleButton.translatesAutoresizingMaskIntoConstraints)
//        print(cardView.translatesAutoresizingMaskIntoConstraints)
//        print(purpleView.translatesAutoresizingMaskIntoConstraints)
        //     //위치, 크기, 추가
        sampleButton.frame = CGRect(x: 100, y: 400, width: 100, height: 100)
        sampleButton.backgroundColor = .red
        view.addSubview(sampleButton)
        
        cardView.posterImageVIew.backgroundColor = .lightGray
        cardView.likeButton.backgroundColor = .red
        cardView.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)

    }
    @objc func likeButtonClicked() {
        print("버튼클릭")
    }

    @IBAction func colorPickerButtonClicked(_ sender: UIButton) {
        showAlert(title: "칼러피커", message: nil ,okTitle: "띄우기") {
            let picker = UIColorPickerViewController() // uifontViewController
            self.present(picker,animated: true)
        }
    }

    @IBAction func backgroundColorChaged(_ sender: UIButton) {
        showAlert(title: "백그라운드", message: "색상변경할꺼?",okTitle: "변경해!",okAction: {
            self.view.backgroundColor = .gray
        })
    }
}
extension UIViewController {
    func showAlert(title: String, message: String?, okTitle: String, okAction: @escaping () -> () ) { // 함수 정의( @escaping은 함수가 밖에 선언되있어서 써준거) , 탈출클로저라함.
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style:.cancel)
        let ok = UIAlertAction(title: okTitle, style: .default) { action in
//            print(action.title ?? "ㅃ")
//            self.view.backgroundColor = .gray
            okAction()
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        present(alert,animated: true)
    }
}
