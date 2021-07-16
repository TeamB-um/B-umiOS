//
//  ButtonSectionView.swift
//  B-umiOS
//
//  Created by kong on 2021/07/05.
//

import SnapKit
import UIKit

class ButtonSectionView: UICollectionReusableView {
    // MARK: - UIComponenets
    
    static let identifier = "ButtonSectionView"
    
    private let gradationBackground = UIImageView().then {
        $0.image = UIImage(named: "mywritingTrashbinBgGradientTop")
    }
    private let categoryButtton: RoundingButton = {
        let button = RoundingButton()
        button.setupRoundingButton(title: "전체 카테고리", image: "btnFilter")
        button.addTarget(self, action: #selector(didTapAddButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private let deleteButton: RoundingButton = {
        let button = RoundingButton()
        button.setupRoundingButton(title: "삭제", image: "btnRemove")
        button.addTarget(self, action: #selector(didTapDeleteButton(_:)), for: .touchUpInside)
        
        return button
    }()
    
    let confirmButtton: RoundingButton = {
        let button = RoundingButton()
        button.setupRoundingButton(title: "확인", image: "btnCheckUnseleted")
        button.addTarget(self, action: #selector(didTapConfirmButton(_:)), for: .touchUpInside)
        button.isHidden = true
        
        return button
    }()
    
    let backgroundView = UIView().then {
        $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        $0.frame = CGRect(origin: .zero, size: CGSize(width: SizeConstants.screenWidth, height: 600))
    }
    
    // MARK: - Properties
    
    var isSelectAllowed: Bool = false
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    // MARK: - Methods
    
    private func setConstraint(){
        self.addSubviews([gradationBackground, categoryButtton, deleteButton, confirmButtton])
        
        gradationBackground.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        categoryButtton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(16 * SizeConstants.screenRatio)
            make.width.equalTo(137)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.centerY.equalTo(categoryButtton)
            make.leading.equalTo(categoryButtton.snp.trailing).offset(8)
            make.width.equalTo(80.5)
        }
        
        confirmButtton.snp.makeConstraints { make in
            make.centerY.equalTo(deleteButton)
            make.leading.equalTo(deleteButton.snp.trailing).offset(8)
            make.width.equalTo(80.5)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraint()
        addObservers()
    }
    
    // MARK: - Action
    func addObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(confirmButtonIsActive), name: NSNotification.Name.confirmButtonIsActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(confirmButtonIsunActive), name: NSNotification.Name.confirmButtonIsUnactive, object: nil)
    }
    
    @objc
    private func didTapAddButton(_ sender: UIButton) {
        let popUpVC =  FilterBottmSheetViewController()
        
        popUpVC.modalPresentationStyle = .overFullScreen
        popUpVC.modalTransitionStyle = .coverVertical
        popUpVC.bgDelegate = self
        
        DispatchQueue.main.async {
            let window = UIApplication.shared.windows.first
            
            window?.addSubview(self.backgroundView)
        }
        
        self.parentViewController?.present(popUpVC, animated: true, completion: nil)
    }
    
    @objc
    func didTapCategoryButton(_ sender: UIButton) {
        if categoryButtton.isSelected {
            categoryButtton.setupRoundingButton(title: "전체 카테고리", image: "btnFilter", selected: true)
        } else {
            categoryButtton.setupRoundingButton(title: "서버에서", image: "btnFilterWhite", selected: false)
        }
    }
    
    @objc
    func didTapDeleteButton(_ sender: UIButton) {
        if deleteButton.isSelected {
            deleteButton.setupRoundingButton(title: "삭제", image: "btnRemove", selected: true)
            confirmButtton.isHidden = true
        } else {
            deleteButton.setupRoundingButton(title: "취소", image: "btnCancel", selected: true)
            confirmButtton.isHidden = false
        }
        NotificationCenter.default.post(name: NSNotification.Name.deleteButtonIsSelected, object: deleteButton.isSelected)
    }
    
    @objc
    func didTapConfirmButton(_ sender: UIButton) {
        if confirmButtton.isSelected {
            let popUpVC =  DeletePopUpViewController(kind: .writing)
            popUpVC.modalPresentationStyle = .overFullScreen
            popUpVC.modalTransitionStyle = .crossDissolve
            
            self.parentViewController?.present(popUpVC, animated: true, completion: nil)
        }
    }
    
    @objc func confirmButtonIsActive(noti : NSNotification){
        confirmButtton.isActivated(true)
        confirmButtton.isSelected = true
    }
    
    @objc func confirmButtonIsunActive(noti : NSNotification){
        confirmButtton.isActivated(false)
        confirmButtton.isSelected = false
    }
    
    // MARK: - Protocols
}

extension ButtonSectionView : viewDelegate {
    func backgroundRemove() {
        backgroundView.removeFromSuperview()
    }
}

protocol viewDelegate {
    func backgroundRemove()
}
