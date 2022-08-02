import UIKit

import Alamofire
import SwiftyJSON
/**
 
 프로토콜 :
 - delegate
 - datasource
 
 1, 왼팔delegate/오른팔datasource
 2. 테이블뷰 아웃렛 연결
 3. 1번 2번 합친거
 */


/*
 
 */
extension UIViewController{
    func BackgroundColor(){
        view.backgroundColor = .red
    }
}

class SearchViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchBar: UISearchBar!
    //    @IBOutlet weak var third: UITableView!
//    @IBOutlet weak var second: UITableView!
    @IBOutlet weak var searchtableView: UITableView!
    
    //boxoffice 담을 배열
    var list: [BoxOfficeModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        //연결고리 작업 : 테이블뷰가 해야할 역할 > 뷰컨트롤러에게 요청
        searchtableView.delegate = self
        searchtableView.dataSource = self
        // 테이블뷰 사용할 테이블뷰 셀(XIB)등록
        //xib: xml interface builder (예전엔 NIB이라불림)
        searchtableView.register(UINib(nibName: ListTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.identifier)
        requestBoxOffice(text: "20220801")
        searchBar.delegate = self
    }
    
    func configureView() {
        
    }
    func configureLabel() {
        
    }
    func requestBoxOffice(text: String) {
        list.removeAll()
        //인증키 제한
        let url = "\(EndPoint.boxOfficeURL)key=\(APIKey.BOXOFICE)&targetDt=\(text)"
        AF.request(url, method: .get).validate().responseJSON { [self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
                //                let movieNm1 = json["boxOfficeResult"]["dailyBoxOfficeList"][0]["movieNm"].stringValue
                //                let movieNm2 = json["boxOfficeResult"]["dailyBoxOfficeList"][1]["movieNm"].stringValue
                //                let movieNm3 = json["boxOfficeResult"]["dailyBoxOfficeList"][2]["movieNm"].stringValue
                //                //배열 리스트 추가
                //                ls.append(movieNm1)
                //                ls.append(movieNm2)
                //                ls.append(movieNm3)
             
                for item in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue { //arrayValue하면 그 값의 배열원소 하나하나가 item이 된다.
                    print(item)
                    let movieNm = item["movieNm"].stringValue
                    let openDtt = item["openDt"].stringValue
                    let audiAcc = item["audiAcc"].stringValue
                    let data = BoxOfficeModel(movieTitle: movieNm, releseDate: openDtt, totalCount: audiAcc)
                    list.append(data)
                }

                searchtableView.reloadData() //데이터가 모두 ls에 추가된뒤 갱신(reload)해줘야한다.

                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // UIviewController에 있는게 아니잖아 그래서 override하면 오류남
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier, for: indexPath) as? ListTableViewCell else{return UITableViewCell()}
        cell.backgroundColor = .clear
        cell.titleLabel.font = .boldSystemFont(ofSize: 22)
        cell.titleLabel.text = "\(list[indexPath.row].movieTitle) : \(list[indexPath.row].releseDate)"
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {return}
        requestBoxOffice(text: searchText)
    }
}
