
import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher
class ImageSearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    var totalCount = 0
    var imageArray : [String] = []
    var startpage = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self // 서비차와 서버통신할떄 해줌
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        layoutSetting()
    }
    
    // fetchImage, requestImage, getImage, callRequestImage ...etc response에 따라 네이밍설명해주기도함.
    func fetchImage(query: String) {
        ImageSearchAPIManager.shared.fetchImageData(query: query, startpage: startpage) { totalCount, imageArray in
            self.totalCount = totalCount
            self.imageArray.append(contentsOf: imageArray)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    //MARK: 레이아웃잡기
    func layoutSetting() {
        let layout = UICollectionViewFlowLayout()
        let spacing : CGFloat = 8
        let layoutwidth = UIScreen.main.bounds.width - (spacing * 4)
        layout.itemSize = CGSize(width: (layoutwidth / 3), height: (layoutwidth / 3) * 1.2)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        collectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        
        let imageurl = URL(string: imageArray[indexPath.item])
        cell.gagaImageView.kf.setImage(with:imageurl)
        
        return cell
    }
    /*
     페이지네이션 방법 3가지

     1.will display cell (보여줄예정..) -> 실제로 그려주는애 (권장 X)

     2.scrollview scroll 시점 활용  ( 가장많이사용, 보편적인방법) , 특정시점에 다다르면 하단이 더 보이게

     3. protocol datasourceprefetching
     */
    
    // 페이지네이션 방법1: 컬렉션뷰가 특정셀 그리려는 시점에 호출되는 메서드( 권장하는방법은 아님)
    // 마지막 셀에 사용자가 위치해있는지 명확하게 확인하기 어려워
    // func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    //  <#code#>
    // }
    
    // 페이지네이션 방법2: UIScrollViewDelegateProtocol
    // 테이블뷰,컬렉션뷰,스크롤뷰 상속받고있어서, 스크롤뷰 프로토콜을 사용할수있다.
    // func scrollViewDidScroll(_ scrollView: UIScrollView) { // 스크롤 될떄마다 동작
    //    print(scrollView.contentOffset) //얼마만큼 사용자가 내려왓는지 확인이 가능
    // }
}

// 페이지네이션 방법3 : 용량큰 이미지 다운받아 셀 보여주는경우에 효과적 .
// 셀이 화면에 보이기 전에 미리 필요한 리소스를 다운받을수있고, 필요하지 않다면 데이터를 취소할수있음.
// ios10 이상부터 사용가능 스크롤 성능항상됨.
extension ImageSearchViewController: UICollectionViewDataSourcePrefetching {
    // 셀이 화면에 보이기 직전에 필요한 리소스를 미리 다운받는기능
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        // indexPaths는 배열, 0부터 시작
        for index in indexPaths{
            print(imageArray.count)
            
            if (imageArray.count - 1 == index.item) && (imageArray.count < totalCount){
                startpage += 30
                fetchImage(query: searchBar.text!)
            }
        }
        print("==========\(indexPaths)")
    }
    // 취소(엄청빠르게 사용자가 스크롤할떄)
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print("취소취소취소취소\(indexPaths)")
    }
    
}


extension ImageSearchViewController : UISearchBarDelegate {
    // 검색 버튼 클릭시 실행
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            imageArray.removeAll()
            startpage = 1
//            collectionView.scrollToItem(at: <#T##IndexPath#>, at: <#T##UICollectionView.ScrollPosition#>, animated: <#T##Bool#>)
            fetchImage(query: text)
        }
    }
    
    //취소버튼눌를떄 실행
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        imageArray.removeAll()
        collectionView.reloadData()
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
    }
    //서치바에서 커버가 깜빡이기 시작할떄 실행
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
}


