//
//  ViewController.swift
//  week6
//
//  Created by useok on 2022/08/08.
//

import UIKit

import Alamofire
import SwiftyJSON //가져온 json파일을 이용,활용

/*
 1. html tag <> </> 기능활용 -> html 관련된거 처리 , html코드가 많을떄 사용
 2. 문자열 대체 메서드 호출 <b>,</b> 같이 개수가 적은건 대체
 response 애서 처리하는것과 보여지는 셀 에서 처리하는것의 차이는?

 tableView automaticDimension
 - 컨텐츠 양따라 셀높이가 자유
 - 조건 레이블 numberofrow 0
 - 조건 tableview height 설정
-  조건 레이아웃 잘잡기

 */


class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var bloglist : [String] = []
    var cafelist : [String] = []
    
    var isExpaneded = false // 라벨길이 false면 두줄 ture면 전체보기
    override func viewDidLoad() {
        super.viewDidLoad()
        // start -> end -> requestBlog 순서로 실행  ( 네트워크 통신시 코드가 꼭 순서대로 진행되진않음)
        print(#function,"start")
//        requestBlog(query: "고래밥")
        //        requestBlog(query: "죠스바") // 주의: 죠스바랑 고래밥중 어떤게더 빨리 response(도착)하는지 알수없음
        searchBlog()
        print(#function,"end")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension //모든섹션의 셀에대해 유동적
    }
    
    // almofire + swiftjson
    // 검색키워드
    // 인증키
    func requestBlog(query: String) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        // EndPoint.blog.requestURL: ~blog?query=
        let url = EndPoint.blog.requestURL + query
        let header : HTTPHeaders = ["Authorization" : "KakaoAK \(APIKey.kakao)"]
        
//        DispatchQueue.global().async { //이부분이 비동기처리해주는 부문
//            <#code#>
//        }

        // alamofire -> URLSession Framework(alamofire가 포함된 프레임워크)로 인해 코드로 구현안해도 비동기로 요청, 메인쓰레드로 바뀜.(메인쓰레드로 안바뀌면 원래 보라색오류뜸)
        //이제부터 비동기부문(코드순서가 이거떄매 달라진다)
        AF.request(url, method: .get ,headers: header).validate().responseJSON { [self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(#function)
                print("JSON: \(json)")
                
//                DispatchQueue.main.async { //메인쓰레드로 바꿈
                    //테이블뷰 갱신 tableView.reloads()
//                }
                self.requestCafe(query: "고래밥카페") // 이거를쓰면 동작이끝난후 requestcafe호출  , 추가로 이거넣으면 tableView.reloads() 필요없음(같이 갱신이됨)
            case .failure(let error):
                print(error)
            }
        }
//        self.requestCafe()  여기에하면 AF.request(~~) 요청하고 요청되는동안 requestCafe()가 실행됨.   (클로저 영역이 나중에 동작하는 형태이다)
        
    }
    
    func requestCafe(query: String) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        let url = EndPoint.cafe.requestURL + query
        let header : HTTPHeaders = ["Authorization" : "KakaoAK \(APIKey.kakao)"]
        
        AF.request(url, method: .get ,headers: header).validate().responseJSON { [self] response in
            switch response.result {
            case .success(let value):
                print(#function)
                let json = JSON(value)
                print("JSON: \(json)")

            case .failure(let error):
                print(error)
            }
        }
    }
    
    func searchBlog() {
        // requestBlog,requestCafe 를 반복되는거 줄여서 사용
        KakaoAPIManager.shared.callRequest(query: "고래밥", type: .blog) { json in //json은 문자열 덩아리
//            print("=======================",json)
            for item in json["documents"].arrayValue {
                self.bloglist.append(item["contents"].stringValue)
            }
            // 여기서 갱신 or 다른 네트워크 통신 호출(self.searchCafe())
            self.searchCafe()
        }
    }
    func searchCafe() {
        KakaoAPIManager.shared.callRequest(query: "고래밥", type: .blog) { json in //json은 문자열 덩아리
            for item in json["documents"].arrayValue {
                let val = item["contents"].stringValue.replacingOccurrences(of: "</b>", with: "").replacingOccurrences(of: "<b>", with: "") // </b>,<b> -> ""로 바꿈
                
                
                
                self.cafelist.append(val)
            }
            // 여기서 갱신 or 다른 네트워크 통신 호출(self.searchCafe())
            print("blog/////// ",self.bloglist)
            print("cafe///////",self.cafelist)
            self.tableView.reloadData()
        }
        
    }
    
    @IBAction func expandCell(_ sender: UIBarButtonItem) {
        isExpaneded = !isExpaneded
        tableView.reloadData()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { //색션개수
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //로우개수
        return section == 0 ? bloglist.count : cafelist.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "kakaoCell", for: indexPath) as? kakaoCell else{
            return UITableViewCell()
        }
        cell.testLabel.numberOfLines = isExpaneded ? 0 : 2
        cell.testLabel.text = indexPath.section == 0 ? bloglist[indexPath.row] : cafelist[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { //색션 명
        return section == 0 ? "블로그검색결과" : "카페 검색결과"
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { //셀 높이
        return UITableView.automaticDimension // label 기준으로 높이나옴.
    }
}

class kakaoCell: UITableViewCell {
    @IBOutlet weak var testLabel: UILabel!
    
}
