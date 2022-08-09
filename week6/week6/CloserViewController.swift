import UIKit

class CloserViewController: UIViewController {

    @IBOutlet weak var cardView: cardView!
    override func viewDidLoad() {
        super.viewDidLoad()
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
