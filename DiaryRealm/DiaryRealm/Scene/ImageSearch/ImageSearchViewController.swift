
import UIKit
import Kingfisher

class SearchImageViewController: BaseViewController {

    var delegate: SelectImageDelegate?

    var selectedImage: UIImage?
    var selectIndexPath: IndexPath?
    
    let mainView = ImageSearchView()

    override func loadView() {
        self.view = mainView
    }
    
    var imageList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Constants.BaseColor.background
        
        
    }

    override func configure() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.register(ImageSearchCollectionViewCell.self, forCellWithReuseIdentifier: ImageSearchCollectionViewCell.reuseIdentifier)

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonClicked))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(selectButtonClicked))
        
//        view.isUserInteractionEnabled = false // 서버통신전 뭔가 누르면 안되므로 뷰의 모든 걸 막아둔다
//        mainView.collectionView.isUserInteractionEnabled = false // 컬렉션뷰에대해서만 인터렉션안되게 막아둔다
    }
    
    @objc func backButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc func selectButtonClicked() {
        // 이미지 선택 안하면 앨럿
        guard let selectedImage = selectedImage else {
            showAlertMessage(title: "사진을 선택해주세요", button: "확인")
            return
        }
        // 선택한 이미지 전달
        delegate?.sendImageData(image: selectedImage) // WriteViewController.sendImageData(image: selectedImage)로 보자
        dismiss(animated: true)
    }
    
}
 
extension SearchImageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UINavigationControllerDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ImageDummy.data.count
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageSearchCollectionViewCell.reuseIdentifier, for: indexPath) as? ImageSearchCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.layer.borderWidth = (selectIndexPath == indexPath) ? 4 : 0  // 선택된건 4 굵기, 안된건 1  원래 1->0
        cell.layer.borderColor = (selectIndexPath == indexPath) ? Constants.BaseColor.point.cgColor : nil //선택된건 붉은색, 안된건 그린 원래 green -> nil
        cell.setImage(data: ImageDummy.data[indexPath.item].url)
        return cell
    }
    // 셀 선택시
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //어떤 셀인지 어떤 이미지를 가지고 올 지 어떻게 알까?
        guard let cell = collectionView.cellForItem(at: indexPath) as? ImageSearchCollectionViewCell else { return }
        
        selectedImage = cell.searchImageView.image
        selectIndexPath = indexPath
        collectionView.reloadData() // 어떤셀은 테두리줘야하고 어떤셀은 테두리 안해줘야하니 리로드

        
    }
    //선택한 셀 해제
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        print(#function)
        selectIndexPath = nil
        selectedImage = nil
        
        collectionView.reloadData()
    }
}

