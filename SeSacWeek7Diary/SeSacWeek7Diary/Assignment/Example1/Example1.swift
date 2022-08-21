//
//  Example1.swift
//  SeSacWeek7Diary
//
//  Created by useok on 2022/08/20.
//

import Foundation
import UIKit
import Kingfisher

class Example1: UIView, ConstraintOffsetTarget, ConstraintOffsetTarget, ConstraintOffsetTarget {
    //MARK: 연결하기
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: 크기잡기
    //백그라운드 이미지
    let backImageView: UIImageView = {
        let backimage = UIImageView()
        let url = URL(string: "https://image.yes24.com/goods/24937314/XL")
        backimage.kf.setImage(with:url)
        backimage.contentMode = .scaleToFill
        backimage.alpha = 0.9
       return backimage
    }()
    // 백그라운드 효과주기위한 뷰
    let foreView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.4
        return view
    }()
    //프로필명
    let profileName: UILabel = {
        let label = UILabel()
        label.text = "Mini"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20,weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    //취소버튼
    lazy var cancelButton: UIButton = {
        topButtonConfig(name: "xmark")
    }()
    //설정버튼
    lazy var settingButton: UIButton = {
        topButtonConfig(name: "gearshape.circle")
    }()
    //송금하기 버튼
    lazy var bankButton: UIButton = {
        topButtonConfig(name: "die.face.5")
    }()
    // 선물하기버튼
    lazy var presentButton: UIButton = {
        topButtonConfig(name: "gift.circle")

    }()
    // 프로필편집 버튼
    lazy var profileEditingButton: UIButton = {
        bottomButtonConfig(name: "pencil.circle", title: "프로필편집")
    }()
    // 나와의채팅 버튼
    lazy var myChatButton: UIButton = {
        bottomButtonConfig(name: "bubble.left.fill", title: "나와의채팅")
    }()
    // 카카오스토리 버튼
    lazy var kakaoStoryButton: UIButton = {
        bottomButtonConfig(name: "bookmark.fill", title: "카카오스토리")
    }()
    // 프로필이미지
    let profileImageVIew: UIImageView = {
        let image = UIImageView()
        let url = URL(string: "https://contents.lotteon.com/itemimage/_v132701/LO/17/36/22/92/64/_1/73/62/29/26/5/LO1736229264_1736229265_1.jpg/dims/resizef/554X554")
        image.kf.setImage(with:url)
        image.backgroundColor = .gray
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 20
        return image
    }()

    // 하단뷰 검은선
    let blackLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    //MARK: 위치잡기
    // view에 그리기
    func configureUI() {
        [backImageView,foreView,cancelButton,settingButton,bankButton,presentButton,profileImageVIew,blackLine,profileEditingButton,myChatButton,kakaoStoryButton,profileName].forEach {
            self.addSubview($0)
        }
    }
    func setConstrains() {
        //백그라운드 이미지
        backImageView.snp.makeConstraints {
            $0.topMargin.equalTo(self.safeAreaLayoutGuide)
            $0.leadingMargin.equalTo(self.safeAreaLayoutGuide)
            $0.trailingMargin.equalTo(self.safeAreaLayoutGuide)
            $0.bottomMargin.equalTo(self.safeAreaLayoutGuide)
        }
        //백그라운드 효과주기위한 뷰
        foreView.snp.makeConstraints {
            $0.topMargin.equalTo(self.safeAreaLayoutGuide)
            $0.leadingMargin.equalTo(self.safeAreaLayoutGuide)
            $0.trailingMargin.equalTo(self.safeAreaLayoutGuide)
            $0.bottomMargin.equalTo(self.safeAreaLayoutGuide)
        }

        //취소 버튼
        cancelButton.snp.makeConstraints {
            
//            $0.width.height.equalTo(self.bounds.width / 7)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(self) // 숫자는 적용되는데 왜 안떨어져? ㅠ 이유를 찾자!  원래는 3
            $0.top.equalTo(self.safeAreaLayoutGuide)

        }
        //설정 버튼
        settingButton.snp.makeConstraints {
            $0.size.width.height.equalTo(self.bounds.width / 7)
            $0.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.top.equalTo(self.safeAreaLayoutGuide)

        }
        //송금하기 버튼
        bankButton.snp.makeConstraints {
            $0.size.width.height.equalTo(settingButton.snp.size)
            $0.top.equalTo(settingButton.snp.top)
            $0.trailing.equalTo(settingButton.snp.leading).offset(-3)
        }
        // 선물하기 버튼
        presentButton.snp.makeConstraints {
            $0.size.width.height.equalTo(settingButton.snp.size)
            $0.top.equalTo(settingButton.snp.top)
            $0.trailing.equalTo(bankButton.snp.leading).offset(-3)
        }
        //프로필 이미지
        profileImageVIew.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.size.width.height.equalTo(self.bounds.width / 4)
            $0.bottom.equalTo(blackLine.snp.bottom).offset(-(self.bounds.height/8))

        }
        //프로필이름
        profileName.snp.makeConstraints{
            $0.centerX.equalToSuperview()

            $0.size.height.equalTo(self.bounds.height/20)
            $0.bottom.equalTo(profileImageVIew.snp.bottom).offset(self.bounds.height/15)

        }
        //하단뷰 검은선
        blackLine.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-(self.bounds.height/7))
            $0.leadingMargin.equalTo(0)
            $0.trailingMargin.equalTo(0)
            $0.height.equalTo(1)
        }
        //프로필 편집 버튼
        profileEditingButton.snp.makeConstraints {
            $0.top.equalTo(blackLine.snp.bottom).offset(20)
            $0.centerX.equalTo(self)
        }
        // 카카오스토리 버튼
        kakaoStoryButton.snp.makeConstraints {
            $0.leading.equalTo(profileEditingButton.snp.trailing).offset(40)
            $0.top.equalTo(profileEditingButton.snp.top)
        }
        //나와의채팅 버튼
        myChatButton.snp.makeConstraints {
            $0.trailing.equalTo(profileEditingButton.snp.leading).offset(-40)
            $0.top.equalTo(profileEditingButton.snp.top)
        }
    }

    //하단 버튼 디자인
    func bottomButtonConfig(name: String, title: String)-> UIButton {
        let buttonView = UIButton()
        var configuration = UIButton.Configuration.borderless()
        configuration.subtitle = title
        configuration.imagePlacement = .top
        configuration.imagePadding = 5
        configuration.titleAlignment = .center
        buttonView.configuration = configuration
        buttonView.tintColor = .black
        let config = UIImage.SymbolConfiguration(pointSize: 35, weight: .thin, scale: .default)
        buttonView.setImage(UIImage(systemName: name, withConfiguration: config), for: .normal)
        buttonView.tintColor = .white
        return buttonView
    }

    //상단 버튼 디자인
    func topButtonConfig(name: String)-> UIButton {
        let buttonView = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .thin, scale: .default)
        buttonView.setImage(UIImage(systemName: name, withConfiguration: config), for: .normal)
        buttonView.tintColor = .white
        return buttonView
    }
    
    
    
}
