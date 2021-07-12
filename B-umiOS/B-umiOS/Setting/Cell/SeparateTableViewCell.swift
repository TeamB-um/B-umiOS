//
//  TrashBinTableViewCell.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/05.
//

import UIKit

class SeparateTableViewCell: UITableViewCell {
    // MARK: - UIComponenets
    
    var seperateName = UILabel().then {
        $0.textColor = .paper4
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 16)
        $0.addTarget(SeparatePopUpViewController.identifier, .popup)
    }
    
    lazy var modifyButton = UIButton().then {
        $0.addTarget(self, action: #selector(didTapModifyButton(_:)), for: .touchUpInside)
        $0.backgroundColor = .clear
    }
    
    lazy var deleteButton = UIButton().then {
        $0.setImage(UIImage(named: "btnDelete"), for: .normal)
        $0.addTarget(self, action: #selector(didTapDeleteButton(_:)), for: .touchUpInside)
    }
    
    // MARK: - Properties
    
    static let identifier = "SeparateTableViewCell"
    var textdelegate : TextDelegate?
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle
    
    // MARK: - Actions
    
    @objc
        private func didTapDeleteButton(_ sender: UIButton) {
            print("click")
        }
    
    @objc
        private func didTapModifyButton(_ sender: UIButton) {
            
            let storyBoard = UIStoryboard(name: "Setting", bundle: Bundle.main)
            if let nextVC = storyBoard.instantiateViewController(identifier: SeparatePopUpViewController.identifier) as? SeparatePopUpViewController{
                
                self.textdelegate = nextVC
                textdelegate?.sendData(name: seperateName.text ?? "")
                
                nextVC.method = .modify
                nextVC.modalPresentationStyle = .overFullScreen
                nextVC.modalTransitionStyle = .crossDissolve
                self.window?.rootViewController?.present(nextVC, animated: true, completion: nil)
            }
        }
    
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
        self.contentView.addSubviews([seperateName, modifyButton, deleteButton])
        
        seperateName.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(24 * SizeConstants.screenRatio)
            make.top.bottom.equalToSuperview().inset(14 * SizeConstants.screenRatio)
        }
        
        modifyButton.snp.makeConstraints { make in
            make.edges.equalTo(seperateName)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.centerY.equalTo(seperateName)
            make.trailing.equalToSuperview().inset(24 * SizeConstants.screenRatio)
        }
    }
}
