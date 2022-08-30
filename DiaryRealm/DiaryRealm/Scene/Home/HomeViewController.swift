
import UIKit
import SnapKit
import RealmSwift //Realm 1. import
import FSCalendar
class HomeViewController: BaseViewController{
    static var identifier = "HomeViewController"
    let localRealm = try! Realm() // Realm 2. Realm은 default.realm
    
    let repository = UserDiaryRepository() 
    
//    lazy var calendar: FSCalendar = {
//        let view = FSCalendar() //  nibName: , bundle: 은 이름,번들아이디뜻하고 아무것도안쓰면
//        view.delegate = self
//        view.dataSource = self
//        view.backgroundColor = .white
//        return view
//    }()
//
    let tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 100
        return view
    }()
    let formatter: DateFormatter = {
       let fomatter = DateFormatter()
        fomatter.dateFormat = "yyMMdd"
        return fomatter
    }()
    
    var tasks: Results<UserDiary>! {
        
        didSet {
            tableView.reloadData()
            print("Tasks Changed")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad() // uiviewcontroller의 viewdidload까지 찾아간다. homeVC-> baseVC-> UiVC의 viewdidloadn
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "cell")
              
    }
     
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        //화면 갱신은 화면 전환 코드 및 생명 주기 실행 점검 필요!
        //present, overCurrentContext, overFullScreen > viewWillAppear X
        fetchRealm()
    }
    
    func fetchRealm() {
        //Realm 3. Realm 데이터를 정렬해 tasks 에 담기
        print("wewewewewe")
//        tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "diaryTitle", ascending: true)
        
        tasks = repository.fetch()
        
    }
    
    override func configure() {
        view.addSubview(tableView)
//        view.addSubview(calendar)
        
        let plusButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonClicked))
        let backupButton = UIBarButtonItem(title:"백업화면" ,style: .plain, target: self, action: #selector(backupClicked2))
        navigationItem.rightBarButtonItems = [plusButton,backupButton]
        let sortButton = UIBarButtonItem(title: "정렬", style: .plain, target: self, action: #selector(sortButtonClicked))
        let filterButton = UIBarButtonItem(title: "필터", style: .plain, target: self, action: #selector(filterButtonClicked))

        navigationItem.leftBarButtonItems = [sortButton, filterButton]
        
    }
    
    @objc func backupClicked2() {
        let vc = BackupViewController()
        transition(vc, transitionStyle: .presentFullNavigation)
    }
    
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
//        calendar.snp.makeConstraints {
//            $0.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
//            $0.height.equalTo(300)
//        }
//
        
    }
    
    @objc func plusButtonClicked() {
        let vc = WriteViewController()
        transition(vc, transitionStyle: .presentFullNavigation)
//        vc.modalPresentationStyle = .fullScreen
//        present(vc, animated: true)
    }
    
    @objc func sortButtonClicked() {
//        tasks = localRealm.objects(UserDiary.self).sorted(byKeyPath: "regdate", ascending: true)
        tasks = repository.fetchSort("regdate")
    }
    
    
    @objc func filterButtonClicked() {
//        tasks = localRealm.objects(UserDiary.self).filter("diaryTitle CONTAINS[c] 'a'")
        tasks = repository.fetchFilter()
    }
    

    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? HomeTableViewCell else {
            print("여기서문제생겨!!!!!!!")
            return UITableViewCell() }
        print("jhgjhgjhgjhgjhghj",tasks)
        print(tasks[indexPath.row])
        cell.setData(data: tasks[indexPath.row])
        cell.diaryImageView.image = loadImageFromDocument(fileName: "\(tasks[indexPath.row].objectId).jpg")
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = tasks?[indexPath.row]
            try! repository.localRealm.write {
                repository.localRealm.delete(item!)
            }
            tableView.reloadData()
        }
    }
    
    // 커스텀 왼쪽 스와이프 액션
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let favorite = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            
            self.repository.updateFavorite(item: self.tasks[indexPath.row])
            
            // realm data update
            try! self.repository.localRealm.write {
                // 하나의 레코드에서 특정 컬럼 하나만 변경
//                self.tasks[indexPath.row].favorite = !self.tasks[indexPath.row].favorite
                
                
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
    
    // 커스텀 오른쪽 스와이프 액션
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let favorite = UIContextualAction(style: .normal, title: "삭제") {  action, view, completionHandler in
            
//            try! repository.localRealm.write{
//                repository.localRealm.delete(tasks[indexPath.row]) // 레코드 삭제
//            }
//            self.removeImageFromDocument(fileName: "\(self.tasks[indexPath.row].objectId).jpg") //도큐먼트의 이미지 삭제 10
            self.repository.deleteItem(item: self.tasks[indexPath.row])
            
            self.fetchRealm() //렘 데이터 가져오기
        }
        // 찾아보기
//        tableView.beginUpdates()
//        tableView.endUpdates()
        
        return UISwipeActionsConfiguration(actions: [favorite])
    }
    
}
//
//extension HomeViewController: FSCalendarDelegate, FSCalendarDataSource {
//    // 밑에 점의개수
//    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
//        return repository.fetchDate(date: date).count
//    }
//    // 캘린더 전체 제목
////    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
////        return "삭제"
////    }
//    // date: yyyyMMdd hh:mm:ss => dateformatter
//    // 캘린더 하위 제목
//    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
////        return "서브삭제"
//        return formatter.string(from: date) == "220907" ? "오프라인" : nil // 220907에만 표시 나머진 nil이라 안뜸
//    }
//    // 날짜아래에 이미지
////    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
////        return UIImage(systemName: "star.fill")
////    }
//
//    // date는 22/8/26 00:00:00 ~ 23:59:59
//    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//        // 선택된 날짜 에대한 내용 일정수
//        tasks = repository.fetchDate(date: date) // tasks는 배열
//    }
//}
