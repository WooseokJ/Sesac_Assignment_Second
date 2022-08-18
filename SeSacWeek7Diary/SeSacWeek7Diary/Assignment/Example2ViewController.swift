//
//  Example2ViewController.swift
//  SeSacWeek7Diary
//
//  Created by useok on 2022/08/18.
//

import UIKit
import SnapKit
import Kingfisher
class Example2ViewController: UIViewController {

    //상단뷰
    let naviView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 42/255, green: 193/255, blue: 188/255, alpha: 1)
        return view
    }()
    //타이틀
    let titleName: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.setTitle("회사 ", for: .normal)
        button.tintColor = .white
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()
    
    //메뉴버튼
    lazy var menuButton: UIButton = {
        buttonDesign(name: "grid")
    }()
    //스마일 버튼
    lazy var smileButton: UIButton = {
        buttonDesign(name: "smile")
    }()
    //종버튼
    lazy var bellButton: UIButton = {
        buttonDesign(name: "bell")
    }()
    // 검색바
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "입력"
        return searchBar
    }()
    //배달 이미지
    lazy var deliveryImage: UIButton = {
        buttonDesign(name: "delivery")
    }()
    //배민 이미지
    lazy var baeminImage: UIButton = {
        buttonDesign(name: "bemin")
    }()
    //포장 이미지
    lazy var takeOutImage: UIButton = {
        buttonDesign(name: "takeOut")
    }()
    //비마트 이미지
    lazy var bmartImage: UIButton = {
        buttonDesign(name: "bmart")
    }()
    //쇼핑라이브
    lazy var shoppingLiveImage: UIButton = {
        buttonDesign(name: "shoppingLive")
    }()
    //선물하기
    lazy var giftImage: UIButton = {
        buttonDesign(name: "gift")
    }()
    //전국별미
    lazy var specialImage: UIButton = {
        buttonDesign(name: "special")
    }()
    //배너이미지
    lazy var bannerImage: UIButton = {
        buttonDesign(name: "banner")
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
         //뷰에 추가
        [naviView,titleName,menuButton,bellButton,smileButton,searchBar,deliveryImage,baeminImage,takeOutImage,bmartImage,shoppingLiveImage,giftImage,specialImage,bannerImage].forEach {
            view.addSubview($0)
        }
        //네비 뷰
        naviView.snp.makeConstraints {
            $0.top.equalTo(0)
            $0.leading.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.size.height.equalTo(view.bounds.height/5)
        }
        //타이블
        titleName.snp.makeConstraints {
            $0.centerX.equalTo(view)
            $0.top.equalTo(menuButton.snp.top)
            
        }
        //메뉴버튼
        menuButton.snp.makeConstraints{
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(view.bounds.width/18)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
        //스마일버튼
        smileButton.snp.makeConstraints{
            $0.top.equalTo(menuButton.snp.top)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-view.bounds.width/18)
        }
        //종 버튼
        bellButton.snp.makeConstraints {
            $0.top.equalTo(menuButton.snp.top)
            $0.trailing.equalTo(smileButton.snp.leading).offset(-view.bounds.width/18)
        }
        //검색바
        searchBar.snp.makeConstraints{
            $0.leadingMargin.equalTo(0)
            $0.trailingMargin.equalTo(0)
            $0.top.equalTo(naviView.snp.bottom).offset(-70)
        }
        //배달 이미지
        deliveryImage.snp.makeConstraints{
            $0.top.equalTo(naviView.snp.bottom).offset(10)
            $0.leadingMargin.equalTo(10)
            $0.height.equalTo(view.bounds.width/3.5)
            $0.width.equalTo(view.bounds.width/2.3)
        }
        //배민1 이미지
        baeminImage.snp.makeConstraints{
            $0.top.equalTo(deliveryImage.snp.top)
            $0.trailingMargin.equalTo(-10)
            $0.height.equalTo(view.bounds.width/3.5)
            $0.width.equalTo(view.bounds.width/2.3)
        }
        //포장 이미지
        takeOutImage.snp.makeConstraints{
            $0.top.equalTo(deliveryImage.snp.bottom).offset(10)
            $0.trailingMargin.equalTo(-10)
            $0.leadingMargin.equalTo(10)
            $0.height.equalTo(view.bounds.height/12)
            
        }
        //비마트 이미지
        bmartImage.snp.makeConstraints{
            $0.top.equalTo(takeOutImage.snp.bottom).offset(10)
            $0.leading.equalTo(deliveryImage.snp.leading)
            $0.height.equalTo(deliveryImage.snp.height)
            $0.width.equalTo(deliveryImage.snp.width)
        }
        //쇼핑라이브
        shoppingLiveImage.snp.makeConstraints{
            $0.top.equalTo(bmartImage.snp.top)
            $0.trailingMargin.equalTo(-10)
            $0.height.equalTo(baeminImage.snp.height)
            $0.width.equalTo(baeminImage.snp.width)
        }
        //선물하기
        giftImage.snp.makeConstraints{
            $0.top.equalTo(bmartImage.snp.bottom).offset(10)
            $0.leading.equalTo(bmartImage.snp.leading)
            $0.height.equalTo(deliveryImage.snp.height)
            $0.width.equalTo(deliveryImage.snp.width)
        }
        //전국별미
        specialImage.snp.makeConstraints{
            $0.top.equalTo(giftImage.snp.top)
            $0.trailing.equalTo(shoppingLiveImage.snp.trailing)
            $0.height.equalTo(baeminImage.snp.height)
            $0.width.equalTo(baeminImage.snp.width)
        }
        //배너이미지
        bannerImage.snp.makeConstraints{
            $0.top.equalTo(specialImage.snp.bottom).offset(10)
            $0.trailingMargin.equalTo(takeOutImage.snp.trailing)
            $0.leadingMargin.equalTo(takeOutImage.snp.leading)
            $0.height.equalTo(view.bounds.height/8)
        }
    }
    
    //버튼 디자인
    func buttonDesign(name: String) -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(named: name), for: .normal)
        return button
    }
}
