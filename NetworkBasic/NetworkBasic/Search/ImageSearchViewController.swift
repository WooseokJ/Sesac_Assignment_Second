
import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher
class ImageSearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var imageArray : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        fetchImage()
        layoutSetting()
    }
    
    
    // fetchImage, requestImage, getImage, callRequestImage ...etc response에 따라 네이밍설명해주기도함.
    func fetchImage() {
        let text = "과자".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let header : HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret": APIKey.NAVER_SECRET]
        let url = EndPoint.imageSearchURL + "query=\(text)&display=30&start=1" // query와 start는 순서상관없음 ,  과자를 그냥넣으면 안됨. query= 내용은 과자를 UTF로 변환(%EA%B3%BC%EC%9E%90& 넣으면 나오긴함(네이버개발자센터 내용)
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseJSON { [self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
                for item in json["items"].arrayValue{
                    print(item)
                    imageArray.append(item["link"].stringValue)
                }
                collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
            
        }
        
    }
    
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

//        cell.gagaImageView.backgroundColor = .blue
        
        return cell
    }
    
}





