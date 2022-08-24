

import UIKit

class BackupViewController: BaseViewController {

    let mainview = BackupView()
    
    override func loadView() {
        super.view = mainview
    }
    
    let tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 100
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainview.backupButton.addTarget(self, action: #selector(backupButtonClicked), for: .touchUpInside)
        mainview.storedButton.addTarget(self, action: #selector(storedButtonClicked), for: .touchUpInside)
        mainview.tableView.delegate = self
        mainview.tableView.dataSource = self
        mainview.tableView.register(BackupTableViewCell.self, forCellReuseIdentifier: "BackupTableViewCell")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(xmarkClicked))

    }
    //백업버튼 클릭시
    @objc func backupButtonClicked() {
        print(1)
    }
    //복구버튼 클릭시
    @objc func storedButtonClicked() {
        print(2)
    }
    @objc func xmarkClicked() {
        dismiss(animated: true)
    }
    
}

extension BackupViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BackupTableViewCell.reuseIdentifier) as? BackupTableViewCell else {return UITableViewCell()}
        cell.backgroundColor = .white
        cell.titleLabel.text = "백업\(indexPath.row)"
        return cell
    }
}
