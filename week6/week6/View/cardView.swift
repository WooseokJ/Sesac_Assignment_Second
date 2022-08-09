//
//  cardView.swift
//  week6
//
//  Created by useok on 2022/08/09.
//

import UIKit
/*
 Xml: 인터페이스 빌드
 1.UIVIEW custom class
 2.file's owner -> 좀더 자유도높음
*/

/*
 view: 1. 인터페이스 빌더 UI 초기화 방법 ( 동작하는 초기화 구문: required init)
       2. 코드로 UI 만들기 방법 ( 동작하는 초기화 구문: override init)
 */

class cardView: UIView {
//    카드라벨
    @IBOutlet weak var cardLabel: UILabel!
    //  포스터이미지
    @IBOutlet weak var posterImageVIew: UIImageView!
//  좋아요 버튼
    @IBOutlet weak var likeButton: UIButton!
// required : 초기화 구문이 프로토콜로 명세되어 있음.
    required init?(coder: NSCoder) {
        super.init(coder:coder) //부모(UIVIEW) 가 초기화
//        fatalError("init(coder:) has not been implemented")
        let view = UINib(nibName: "cardView", bundle: nil).instantiate(withOwner: self).first as! UIView
        view.frame = bounds
        view.backgroundColor = .black
        self.addSubview(view)
        
    }
//    override init(frame: CGRect) {
//        <#code#>
//    }
}

protocol A {
    func example()
    init()
}
