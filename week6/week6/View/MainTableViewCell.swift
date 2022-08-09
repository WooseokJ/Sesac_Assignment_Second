//
//  MainTableViewCell.swift
//  week6
//
//  Created by useok on 2022/08/09.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    //contentCollectionView 도 delegate, datasource 가 필요  -> MainViewController가 필요 
    @IBOutlet weak var contentCollectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        contentCollectionView.collectionViewLayout = collectionViewLayout()

    }

    func setupUI() {
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.text = "넷플릭스 인기 컨텐츠"
        titleLabel.backgroundColor = .clear
        contentCollectionView.backgroundColor = .cyan
    }
    
    func collectionViewLayout()->UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 130)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        return layout
    }
}
