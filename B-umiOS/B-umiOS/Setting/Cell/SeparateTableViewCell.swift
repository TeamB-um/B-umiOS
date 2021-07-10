//
//  TrashBinTableViewCell.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/05.
//

import UIKit

class SeparateTableViewCell: UITableViewCell {

    // MARK: - UIComponenets
    
   var trashbinName = UILabel().then {
        $0.textColor = .paper4
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 16)
    }
    
    var deleteButton = UIButton().then {
        $0.setImage(UIImage(named: "btnDelete"), for: .normal)
    }
    // MARK: - Properties
    
    static let identifier = "SeparateTableViewCell"
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle
    
    // MARK: - Actions
    
    // MARK: - Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .background
        setConstraint()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setConstraint(){
        self.contentView.addSubviews([trashbinName,deleteButton])
        
        trashbinName.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(14 * SizeConstants.screenRatio)
            make.bottom.equalToSuperview().inset(15 * SizeConstants.screenRatio)
            make.leading.equalToSuperview().inset(24 * SizeConstants.screenRatio)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.center.equalTo(trashbinName)
            make.trailing.equalToSuperview().inset(24 * SizeConstants.screenRatio)
        }
        
    }
    
}
