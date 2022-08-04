import UIKit

import Alamofire
import SwiftyJSON
import JGProgressHUD
/**
 프로토콜 :
 - delegate
 - datasource
 1, 왼팔delegate/오른팔datasource
 2. 테이블뷰 아웃렛 연결
 3. 1번 2번 합친거
 */

class SearchViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchtableView: UITableView!
    
    //boxoffice 담을 배열
    var list: [BoxOfficeModel] = []
    let hud = JGProgressHUD()

 
    
    var inputDate : String {
        get{
            //내풀이
//            let date = Date(timeInterval: -86400, since: Date())
//            let formatter = DateFormatter()
//            formatter.dateFormat = "yyyyMMdd"
//            let yesterday = formatter.string(from: date)
//            return yesterday
            //수업
            let format = DateFormatter()
            format.dateFormat = "yyyyMMdd" // yyyy, YYYY 결과는같지만 차이가있음. yyyy쓰면 괜찮
            let yesterday = Calendar.current.date(byAdding: .day, value: -1 ,to: Date())
            let dateResult2 = format.string(from: yesterday!)
            return dateResult2
            // 네트워크 통신: 서버점검등에 대한 예외처리는 항상해줘야ㅕ한다.
            // 네트워크 느린환경에대한 테스트도 중요 : 실제기기로 테스트시 confition조절가능,
            // 시뮬레이션도 가능하지만 추가설치필요(권장하진않음)
        }
    }
    // 타입 어노테이션 vs 타입추론 -> 누가더빠른가?   과거엔 어노테이션이 빨랏지만 요즘엔 추론이더빠름 (하지만 큰차이없음.)
    // what's new in swift
    var nickname: String = "" //타입 어노테이션
    var username = "" //타입추론
    
    override func viewDidLoad() {

        
        super.viewDidLoad()
        //연결고리 작업 : 테이블뷰가 해야할 역할 > 뷰컨트롤러에게 요청
        searchtableView.delegate = self
        searchtableView.dataSource = self
        // 테이블뷰 사용할 테이블뷰 셀(XIB)등록
        //xib: xml interface builder (예전엔 NIB이라불림)
        searchtableView.register(UINib(nibName: ListTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.identifier)
        requestBoxOffice(text: inputDate)
        searchBar.delegate = self
    }
    
    
    
    func requestBoxOffice(text: String) {
        
        hud.textLabel.text = "Loading"
        hud.show(in: view)
        list.removeAll()
        
        //인증키 제한
        let url = "\(EndPoint.boxOfficeURL)key=\(APIKey.BOXOFICE)&targetDt=\(text)"
        //경고창 제거방법 두가지 1. alamofire+ codable, 2. alamofire + response(json,data,string)를알맞은걸로바꾸기
        AF.request(url, method: .get).validate().responseData { [self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                //                let movieNm1 = json["boxOfficeResult"]["dailyBoxOfficeList"][0]["movieNm"].stringValue
                //                let movieNm2 = json["boxOfficeResult"]["dailyBoxOfficeList"][1]["movieNm"].stringValue
                //                //배열 리스트 추가
                //                ls.append(movieNm1)
                //                ls.append(movieNm2)

             
                for item in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue { //arrayValue하면 그 값의 배열원소 하나하나가 item이 된다.
//                    print(item)
                    let movieNm = item["movieNm"].stringValue
                    let openDtt = item["openDt"].stringValue
                    let audiAcc = item["audiAcc"].stringValue
                    let data = BoxOfficeModel(movieTitle: movieNm, releseDate: openDtt, totalCount: audiAcc)
                    list.append(data)
                }

                searchtableView.reloadData() //데이터가 모두 ls에 추가된뒤 갱신(reload)해줘야한다.
                hud.dismiss(animated: true)
                
            case .failure(let error):
                hud.dismiss(animated: true)
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

extension UIViewController{
   func BackgroundColor(){
       view.backgroundColor = .red
   }
}
