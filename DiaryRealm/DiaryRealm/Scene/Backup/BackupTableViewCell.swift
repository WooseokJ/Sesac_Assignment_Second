
import Foundation
import UIKit
import SnapKit

class BackupTableViewCell: BaseTableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    let titleLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    override func configure() {
        [titleLabel].forEach {
            contentView.addSubview($0)
        }
    }
    override func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.centerX.equalTo(contentView)
            $0.leading.equalTo(20)
            $0.trailing.equalTo(-20)
        }
    }
    
}
