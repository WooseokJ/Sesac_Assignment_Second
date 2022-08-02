//
//  BeerTableViewController.swift
//  NetworkBasic
//
//  Created by useok on 2022/08/02.
//

import UIKit

import Alamofire
import SwiftyJSON
class BeerTableViewController: UITableViewController {
    var beerList : [String] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        randomBeerTake()
        view.backgroundColor = .systemYellow
    }
    
//    func randomBeerTake() {
//        let url = "https://api.punkapi.com/v2/beers/random"
//        AF.request(url, method: .get).validate().responseJSON { [self] response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)  // 받아온 데이터를 JSON으로 변환하여 json 변수에 저장
//                print("JSON: \(json)")
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BeerTableViewCell.reuseIdentifier,for: indexPath) as! BeerTableViewCell
        
        cell.beerNameLabel.text = beerList[indexPath.row]
        cell.beerNameLabel.textAlignment = .center
        cell.beerNameLabel.textColor = .blue
        cell.backgroundColor = .systemYellow
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard beerList.count != 1 else{
            return
        }
        if editingStyle == .delete {
            //배열삭제후 테이블뷰 갱신
            beerList.remove(at: indexPath.row)
            tableView.reloadData() //데이터 갱신
        }
    }
 
    
    //밑에꺼 안되는건 row영역을 클릭이 안되므로
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserDefaults.standard.set(beerList[indexPath.row],forKey:"takename") 
       
        dismiss(animated: true)
    }
    
    
}
