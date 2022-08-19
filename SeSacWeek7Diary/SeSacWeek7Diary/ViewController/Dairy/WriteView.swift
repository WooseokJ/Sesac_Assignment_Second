
import UIKit


class WriteView: BaseView {
    
    //이미지뷰
    let photoImageView : UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .lightGray
        return view
    }()
    //이미지 제목
    let titleTextField : UITextField = {
        print("titletextField")
        let view = BlackRediusTextField()
        view.placeholder = "제목을 입력해줘"
        return view
    }()
    //날짜
    let dateTextField : UITextField={
        let view = BlackRediusTextField()
        view.placeholder = "날짜를 입력해줘"
        return view
    }()
    
    //내용
    let contentTextView : UITextView = {
        let view = UITextView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }

    override func configureUI() { // BaseView  상속받은거 오버라이딩
        [photoImageView,titleTextField,dateTextField,contentTextView].forEach {
            self.addSubview($0)
        }
    }
    override func setConstrains() { // BaseView 상속받은거 오버라이딩
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(self).multipliedBy(0.3) //뷰높이 기준에서 * 0.3된거
        }
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(20)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50) //높이
        }
        dateTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50) //높이
        }
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(dateTextField.snp.bottom).offset(20)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
