

import Foundation
import UIKit

class BackupView: BaseView {
    //MARK: 설정
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: 크기
    let tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 100
        return view
    }()
    
    //백업버튼
    let backupButton: UIButton = {
        let button = UIButton()
        button.setTitle("백업", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    //복구
    let storedButton: UIButton = {
        let button = UIButton()
        button.setTitle("복구", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    
    //MARK: 뷰 등록
    override func configureUI() {
        [backupButton,storedButton,tableView].forEach {
            self.addSubview($0)
        }
    }
    
    
    //MARK: 위치
    override func setConstraints() {
        backupButton.snp.makeConstraints {
            $0.top.equalTo(200)
            $0.leading.equalTo(40)
            $0.width.equalTo(70)
        }
        
        storedButton.snp.makeConstraints {
            $0.top.equalTo(backupButton.snp.top)
            $0.leading.equalTo(backupButton.snp.trailing).offset(30)
            $0.width.equalTo(70)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(backupButton.snp.bottom).offset(50)
            $0.leading.equalTo(20)
            $0.trailing.equalTo(-20)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-30)
            
        }
    }
    
    
    
    
}
