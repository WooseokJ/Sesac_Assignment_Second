//
//  HomeViewController.swift
//  SeSacWeek7Diary
//
//  Created by useok on 2022/08/22.
//

import UIKit
import SnapKit
import RealmSwift // MARK: Realm1. import

class HomeViewController: UIViewController {

    
    let localRealm = try! Realm() // MARK: Realm 2. 선언

    lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .lightGray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell") // UITableViewCell.Self를 하면 UITableViewCell에 모든 속성가져옴.
        return view
    }() // let으로 하면 즉시실행 클로저

    var tasks: Results<Userdiary>! {
        didSet {
            tableView.reloadData() // 정렬,필터,즐겨찾기떄 많이사용
            print("tasks chaged")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //MARK: Realm 3. Realm데이터를 정렬해 tasks에 담기
        let tasks = localRealm.objects(Userdiary.self).sorted(byKeyPath: "diaryDate",ascending: false)
        

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(plusButtonClicked))
        
        let sortButton = UIBarButtonItem(title: "정렬", style: .plain, target: self, action: #selector(sortButtonClicked))
        let filterButton = UIBarButtonItem(title: "필터", style: .plain, target: self, action: #selector(filterButtonClicked))
        navigationItem.leftBarButtonItems = [sortButton,filterButton]
        
    }
    @objc func sortButtonClicked() {
        tasks = localRealm.objects(Userdiary.self).sorted(byKeyPath: "diaryTitle", ascending: true)
    }
    // realm filter query(램에서만든쿼리), NSPredicate
    @objc func filterButtonClicked() {
        tasks = localRealm.objects(Userdiary.self).filter("diaryTitle = '661오늘의일기'")
//        tasks = localRealm.objects(Userdiary.self).filter("favorite = true")
        tasks = localRealm.objects(Userdiary.self).filter("diaryTitle CONTAINS[c] 'V'") //, [c]를통해 영어로쓰면 대소문자 상관없음.
        print(tasks)
    }
    
    @objc func plusButtonClicked() {
        let vc = WriteViewController()
//        vc.modalPresentationStyle = .
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc,animated: true)
    }

    override func viewWillAppear(_ animated: Bool) { // overFullScreen보다 FullScreen으로 바꾸면 또달라져(vc.modalPresentationStyle = .overFullScreen)   present,overCurrentContext,overFullScrenn 은 viewwillAppear 실행 X
        super.viewWillAppear(animated)
        print(#function,"f")
        fetchRealm()
    }
    func fetchRealm() {
        // 화면갱신은 화면전환코드 및 생명주기실행점검 필요
        tasks = localRealm.objects(Userdiary.self).sorted(byKeyPath: "diaryDate",ascending: false) // diaryDate기준으로 정렬, sorted안하면 objectsid기준으로 추가된순서로 정렬된다.
        // 정렬이된상태로 쿼리에서 가져와서 tasks에 넣음.
//        tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = tasks[indexPath.row].diaryTitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // 스와이핑시 액션
        let favorite = UIContextualAction(style: .normal, title: "즐겨찾기") { action, view, completionHandler in
         
            // realm data update
            try! self.localRealm.write {
                // 1.하나의 레코드에서 특정칼럼 하나만 변경
//                self.tasks[indexPath.row].favorite = !self.tasks[indexPath.row].favorite
                
                //2.하나의 테이블에 특정 칼럼 전체값 변경
                self.tasks.setValue(true,forKey: "favorite")
                
                //3.하나의 레코드에서 여러 칼럼들이 변경
                self.localRealm.create(Userdiary.self, value:["objectId": self.tasks[indexPath.row].objectId, "diaryContent": "변경텍스트", "diaryTitle": "제목수정"] , update: .modified) // .all하면 위에2와 동일효과
                print("favorite button clicked")
            }
            // 1. 스와이프한 셀 하나만 reloadRows 코드 구현 -> 상대적 효율성       // 개수가 정해져있지않은경우 ex.일기10만개 쓸수있음.
            //2. 데이터 변경됬으니 다시 realm에서 데이터 가져오기 -> didset 일관적 형태로 갱신  // 개수가 정해져있는경우 ex.영화탑10
            self.fetchRealm()
            
        }
        let image = tasks[indexPath.row].favorite ? "star.fill" : "star"
        
        favorite.image = UIImage(systemName: image)
        favorite.backgroundColor = .systemPink
        let example = UIContextualAction(style: .normal, title: "예시") { action, view, completionHandler in
            print("example button clicked")
        }
        return UISwipeActionsConfiguration(actions: [favorite,example])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // 스와이핑시 액션
        let favorite = UIContextualAction(style: .normal, title: "즐겨찾기") { action, view, completionHandler in
            print("favorite button clicked")
        }
        let example = UIContextualAction(style: .normal, title: "예시") { action, view, completionHandler in
            print("example button clicked")
        }
        return UISwipeActionsConfiguration(actions: [favorite,example])
    }
    //참고 : tableView editing mode

}
