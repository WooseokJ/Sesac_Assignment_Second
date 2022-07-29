

import UIKit

class TranslateViewController: UIViewController {

    @IBOutlet weak var userTextview: UITextView! //플레이스홀더(Placeholder),action도 없다
        //TextField와 TextView는 차이가 있다.
    
    
    // UIbutton,UITextField -> Action O
    // UITextview,UISearchBar,UIPickerView -> action X (view에서 상속받은건 다 action없음)

    let textViewPlaceholderText = "번역하고싶은문장 작성해보세요."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: 플레이스홀더만들기
        userTextview.delegate = self //일을맡김
        
        // responder chain 은 특정 뷰객체를 선택하게해줌
//        userTextview.resignFirstResponder()
//        userTextview.becomeFirstResponder() //resignFirstResponder보다 우선적임.
        // responderchain<resignFirstResponder()<becomfirstResponder()  become쪽이더우선
        
        userTextview.text = textViewPlaceholderText
        userTextview.textColor = .lightGray
        
        userTextview.font = UIFont(name: "Zapfino", size: 22)
        
        
    }
    

}

extension TranslateViewController : UITextViewDelegate{
    
    //MARK: 한글자마다 실행되는데 한글자씩 변경될떄 마다 실행
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text.count)
    }
    
    // 편집시작할떄(커서가 깜빡이기 시작될떄)
    //MARK: 텍스트뷰글자: 플레이스 홀더랑 글자가 같으면 claer,color도 바꿔주기
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("start")
        if textView.textColor == .lightGray{ //  lightGray이므로 아무것도입력안될떄를 나타냄
            userTextview.text = nil // "" 로해도됨.
            userTextview.textColor = .black
        }
        
    }
    // 편집이 끝났을떄 (커서가 없어지는 순간)
    //MARK: 텍스트뷰글자: 사용자가 아무글자안쓰면 플레이스홀더글자보이게!
    func textViewDidEndEditing(_ textView: UITextView) {
        print("end")
        if textView.text.isEmpty{
            textView.text = textViewPlaceholderText
            textView.textColor = .lightGray
        }
    }
    
    
}
