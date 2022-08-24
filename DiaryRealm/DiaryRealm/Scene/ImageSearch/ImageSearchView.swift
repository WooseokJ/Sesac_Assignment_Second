
import UIKit

class ImageSearchView: BaseView {
     
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: imageCollectionViewLayout())
        return view
    }()
    
    let searchBar: UISearchBar = {
        let view = UISearchBar()
        return view
    }()
     
    override func configureUI() {
        self.addSubview(collectionView)
        self.addSubview(searchBar)
        
    }
 
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(searchBar.snp.bottom)
            
        }
        searchBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
    }
    
    static func imageCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let deviceWidth: CGFloat = UIScreen.main.bounds.width
        let itemWidth: CGFloat = deviceWidth / 3
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.scrollDirection = .vertical
        return layout
    }
}

