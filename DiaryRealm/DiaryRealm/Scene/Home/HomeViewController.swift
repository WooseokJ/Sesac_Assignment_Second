
import UIKit
import SnapKit
import RealmSwift //Realm 1. import

class HomeViewController: BaseViewController {
    
    let localRealm = try! Realm() // Realm 2.
    
    let tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 100
        return view
    }()
    
    var tasks: Results<UserDiary>! {
        
        didSet {
            tableView.reloadData()
            print("Tasks Changed")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "cell")
        //Realm 3. Realm 데이터를 정렬해 tasks 에 담기
              
    }
     
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        
        tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryTitle", ascending: true)
        
        
        //화면 갱신은 화면 전환 코드 및 생명 주기 실행 점검 필요!
        //present, overCurrentContext, overFullScreen > viewWillAppear X
        tableView.reloadData()
        
    }
    
    func fetchRealm() {
        tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryTitle", ascending: true)
        
    }
    
    override func configure() {
        view.addSubview(tableView)
        
        
        let plusButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonClicked))
        
        let backupButton = UIBarButtonItem(title:"백업화면" ,style: .plain, target: self, action: #selector(backupClicked))
        
        navigationItem.rightBarButtonItems = [plusButton,backupButton]
        
        let sortButton = UIBarButtonItem(title: "정렬", style: .plain, target: self, action: #selector(sortButtonClicked))
        let filterButton = UIBarButtonItem(title: "필터", style: .plain, target: self, action: #selector(filterButtonClicked))
        navigationItem.leftBarButtonItems = [sortButton, filterButton]
        
        
    }
    @objc func backupClicked() {
        let vc = BackupViewController()
        transition(vc, transitionStyle: .presentFullNavigation)
    }
    
    
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
    @objc func plusButtonClicked() {
        let vc = WriteViewController()
        transition(vc, transitionStyle: .presentFullNavigation)
//        vc.modalPresentationStyle = .fullScreen
//        present(vc, animated: true)
    }
    
    @objc func sortButtonClicked() {
        tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "regdate", ascending: true)
        
    }
    
    // realm filter query, NSPredicate
    @objc func filterButtonClicked() {
        tasks = localRealm.objects(UserDiary.self).filter("diaryTitle CONTAINS[c] 'a'")
    }
    

    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? HomeTableViewCell else { return UITableViewCell() }
        cell.setData(data: tasks[indexPath.row])
        cell.diaryImageView.image = loadImageFromDocument(fileName: "\(tasks[indexPath.row].objectId).jpg")
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = tasks?[indexPath.row]
            try! localRealm.write {
                localRealm.delete(item!)
            }
            tableView.reloadData()
        }
    }
    
    // 커스텀 스와이프 액션
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let favorite = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            
            // realm data update
            try! self.localRealm.write {
                // 하나의 레코드에서 특정 컬럼 하나만 변경
                self.tasks[indexPath.row].favorite = !self.tasks[indexPath.row].favorite
                
                
                // 하나의 테이블에 특정 컬럼 전체 값을 변경
//                self.tasks.setValue(true, forKey: "favorite")
                
                // 하나의 레코드에서 여러 컬럼들이 변경
//                self.localRealm.create(UserDiary.self, value: ["objectId":self.tasks[indexPath.row].objectId, "diaryContent":"변경테스트", "diaryTitle":"제목임"], update: .modified)
                
                print("Realm Update Succeed, reloadRows 필요")
            }
            
            self.fetchRealm() // 1. 스와이프 셀 하나만 ReloadRows 코드를 구현 => 상대적 효율성
            // 2. 데이터가 변경됐으니 다시 realm에서 데이터 가져오기 => didSet 일관적 형태로 갱신
        }
        
        // realm 데이터 기준
        let image = tasks[indexPath.row].favorite ? "star.fill" : "star"
        
        favorite.image = UIImage(systemName: image)
        favorite.backgroundColor = .systemPink
        
        return UISwipeActionsConfiguration(actions: [favorite])
    }
    
    
    
}
