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

    let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .lightGray
        return view
    }()

    var tasks: Results<Userdiary>!

    override func viewDidLoad() {
        super.viewDidLoad()

        //MARK: Realm 3. Realm데이터를 정렬해 tasks에 담기
        let tasks = localRealm.objects(Userdiary.self).sorted(byKeyPath: "diaryDate",ascending: false)
        print(tasks)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(plusButtonClicked))
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
        
        // 화면갱신은 화면전환코드 및 생명주기실행점검 필요
        tasks = localRealm.objects(Userdiary.self).sorted(byKeyPath: "diaryDate",ascending: false) // diaryDate기준으로 정렬, sorted안하면 objectsid기준으로 추가된순서로 정렬된다.
        // 정렬이된상태로 쿼리에서 가져와서 tasks에 넣음. 
        tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = tasks[indexPath.row].diaryTitle
        return cell
    }
}
