

import UIKit

class MainTableViewCell: UITableViewCell {
    //contentCollectionView 도 delegate, datasource 가 필요  -> MainViewController가 필요 
    @IBOutlet weak var contentCollectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
//        print("MainTableViewCell",#function)
    }

    func setupUI() {
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.text = "넷플릭스 인기 컨텐츠"
        titleLabel.backgroundColor = .clear
        contentCollectionView.backgroundColor = .cyan
        contentCollectionView.collectionViewLayout = collectionViewLayout()
    }
    
    func collectionViewLayout()->UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: self.bounds.size.height)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        return layout
    }
}
