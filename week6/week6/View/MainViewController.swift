//
//  MainViewController.swift
//  week6
//
//  Created by useok on 2022/08/09.
//

import UIKit
/**
 tableView- collectionView > 프로토콜
 
 awakForNib - 셀 UI초기화,셀인스턴스 새로만들떄 호출, 재사용 매커니즘의해 일정횟수이상 호출되지않음
 cellForItemAt - 재사용 될떄마다(사용자에게 보일떄마다) 항상 실행됨.
 prepareForReuse -  재사용되는 셀의 속성을 초기화, 셀이 재사용될떄 초기화하고자 하는값을 넣으면 오류해결가능, 즉 cellforRowAt에 모든 indexPatinitem에대해 조건을 작성하지않아도 됨
 
 collectionview in tableView
 -> 하나의 컬렉션뷰나 테이블뷰 각각 개별일경우  문제없음.
 -> 복합적인구조(함께쓸떄) 테이블셀도 재사용,컬렉션도 재사용되어야함.
 ->
 ->
 
 */
import Kingfisher
class MainViewController: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    let color: [UIColor] = [.systemCyan,.lightGray,.yellow,.orange,.blue]
    let numberList : [[Int]] = [
        [Int](100...110),
        [Int](55...75),
        [Int](5000...5006),
        [Int](51...60),
        [Int](61...70),
        [Int](71...80),
        [Int](81...100)
    ]
    var episodeList : [[String]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        bannerCollectionView.register(UINib(nibName: cardCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: cardCollectionViewCell.reuseIdentifier)
        bannerCollectionView.collectionViewLayout = collectionViewLayout()
        bannerCollectionView.isPagingEnabled = true // device weith
        
        //        TMDBAPIManager.shared.requestEpisodeImage()
        TMDBAPIManager.shared.requestImage { value in
            //            dump(value)
            //  네트워크 통신 ->배열생성(episodeList) -> 배열담기 -> 뷰 등에 표현(ex. 테이블뷰 섹션,컬렉션뷰 셀)

            DispatchQueue.main.async {
                self.episodeList = value
                self.mainTableView.reloadData()
            }
        }
        print(episodeList)
    }
    
    
}
// 테이블뷰
extension MainViewController: UITableViewDelegate,UITableViewDataSource {

    //  테이블뷰 색션개수
    func numberOfSections(in tableView: UITableView) -> Int {

        return episodeList.count
    }
    //  테이블뷰 셀개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    //  테이블뷰 삽입
    //  내부 매개변수 tableView(tableView.deque~~)를 통해 테이블뷰 특정
    //  테이블뷰 객체가 하나일 경우(cell만드는게아닌 tableview로)에는 내부매개변수를 활용하지않아도 문제가 생기지않는다.
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseIdentifier, for: indexPath) as? MainTableViewCell else{return UITableViewCell()}
        cell.backgroundColor = .orange
        cell.titleLabel.text = "\(TMDBAPIManager.shared.tvList[indexPath.section].0) 드라마 다시보기"
        // 테이블뷰 내에 컬렉션뷰각각
        cell.contentCollectionView.backgroundColor = .lightGray
        cell.contentCollectionView.delegate = self
        cell.contentCollectionView.dataSource = self
        cell.contentCollectionView.register(UINib(nibName: cardCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: cardCollectionViewCell.reuseIdentifier)
        cell.contentCollectionView.tag = indexPath.section // section기준이므로
        cell.contentCollectionView.reloadData() // index out of range 해결
        return cell
    }
    
    //  셀높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
}

// 하나의 프로토콜,메서드에서 여러 컬렉션뷰 delegate,datasource구현해야함
// 내부 매개변수(collectionview)가 아닌 명확한 아울렛변수를 사용할경우 특정 collectionView셀을 재사용할수있게 될수있음.
//UICollectionViewDelegateFlowLayout 에서 sizeforitemat을 쓰면 각각다른 높이변화를 줄수있다.
extension MainViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        <#code#>
    //    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == bannerCollectionView ? color.count : episodeList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cardCollectionViewCell.reuseIdentifier, for: indexPath) as? cardCollectionViewCell else{return UICollectionViewCell()}
        
        let cellcolor = (collectionView == bannerCollectionView) ? color[indexPath.item] : (collectionView.tag.isMultiple(of: 2) ? .yellow: .green)
        
        if collectionView == bannerCollectionView {
            cell.cardView.posterImageVIew.backgroundColor = cellcolor
        }
        else{
            cell.cardView.cardLabel.text = ""
            cell.cardView.posterImageVIew.backgroundColor = cellcolor
            print(collectionView.tag)
            let url = URL(string: "\(TMDBAPIManager.shared.imageURL)\(episodeList[collectionView.tag][indexPath.item])")
            cell.cardView.posterImageVIew.kf.setImage(with: url)
            //화면과 데이터는 별개,모든 indexPath.item에대한 조건이 없다면 재사용시 오류발생할수있음.
            //        if indexPath.item < 2{
            //            cell.cardView.cardLabel.text = "\(episodeList[collectionView.tag][indexPath.item])"
            //        }
            
            //        else { //이거안하면 데이터가 재사용되는부분도 생김
            //            cell.cardView.cardLabel.text = "해피"
            //        }
        }
        return cell
    }
    
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: bannerCollectionView.frame.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }
}
