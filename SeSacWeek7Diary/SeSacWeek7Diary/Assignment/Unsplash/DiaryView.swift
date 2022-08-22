//
//  DiaryView.swift
//  SeSacWeek7Diary
//
//  Created by useok on 2022/08/22.
//

import Foundation
import UIKit
import SnapKit

class DiaryView: UIView {
    //MARK: 연결
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstants()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: 크기및디자인
    let searchbar: UISearchBar = {
       let bar = UISearchBar()
        return bar
    }()
    
//    let collectionview: UIcollectionView = {
//        let layout = UICollectionViewLayout()
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.backgroundColor = .systemPink
//        return cv
//    }()
    
    //MARK: 뷰에등록
    func configure() {
        [searchbar].forEach {
            self.addSubview($0)
        }
    }
    //MARK: 위치
    func setConstants() {
        searchbar.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.equalTo(0)
            $0.trailing.equalTo(0)
            
        }
    }

}

//extension DiaryView: UICollectionViewCell,UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        10
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: <#T##String#>, for: <#T##IndexPath#>)
//    }
//    
//}
