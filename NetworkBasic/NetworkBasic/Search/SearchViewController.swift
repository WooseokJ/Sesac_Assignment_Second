//
//  SearchViewController.swift
//  NetworkBasic
//
//  Created by useok on 2022/07/27.
//

import UIKit

/**
 
 프로토콜 :
 - delegate
 - datasource
 
 1, 왼팔delegate/오른팔datasource
 
 2.
 
 */
extension UIViewController{
    func BackgroundColor(){
        view.backgroundColor = .red
    }
}

class SearchViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
//
//    @IBOutlet weak var third: UITableView!
//    @IBOutlet weak var second: UITableView!
    @IBOutlet weak var searchtableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //연결고리 작업 : 테이블뷰가 해야할 역할 > 뷰컨트롤러에게 요청
        searchtableView.delegate = self
        searchtableView.dataSource = self
        // 테이블뷰 사용할 테이블뷰 셀(XIB)등록
        //xib: xml interface builder (예전엔 NIB이라불림)
        searchtableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: ListTableViewCell.identifier)

    }
    // UIviewController에 있는게 아니잖아 그래서 override하면 오류남
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else{return UITableViewCell()}
        cell.backgroundColor = .clear
        cell.titleLabel.font = .boldSystemFont(ofSize: 22)
        cell.titleLabel.text = "hello"
        return cell
                
    }
    



}
