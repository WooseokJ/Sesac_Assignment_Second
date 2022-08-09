//
//  MainViewController.swift
//  week6
//
//  Created by useok on 2022/08/09.
//

import UIKit

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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        bannerCollectionView.register(UINib(nibName: "cardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cardCollectionViewCell")
        bannerCollectionView.collectionViewLayout = collectionViewLayout()
        bannerCollectionView.isPagingEnabled = true // device weith 
    }
}
extension MainViewController: UITableViewDelegate,UITableViewDataSource {
//  색션개수
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberList.count
    }
//  셀개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
//  삽입
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else{return UITableViewCell()}
        cell.backgroundColor = .orange
        cell.contentCollectionView.backgroundColor = .lightGray
        cell.contentCollectionView.delegate = self
        cell.contentCollectionView.dataSource = self
        cell.contentCollectionView.register(UINib(nibName: "cardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cardCollectionViewCell")
        cell.contentCollectionView.tag = indexPath.section // section기준이므로
        return cell
    }

//  셀높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
}

// 하나의 프로토콜,메서드에서 여러 컬렉션뷰 delegate,datasource구현해야함
extension MainViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == bannerCollectionView ? color.count : numberList[collectionView.tag].count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCollectionViewCell", for: indexPath) as? cardCollectionViewCell else{return UICollectionViewCell()}
//
        let cellcolor = (collectionView == bannerCollectionView) ? color[indexPath.item] : (collectionView.tag.isMultiple(of: 2) ? .yellow: .green)
        cell.cardView.cardLabel.text = "\(numberList[collectionView.tag][indexPath.item])"
        cell.cardView.posterImageVIew.backgroundColor = cellcolor
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
