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
    
    let gradationBackground = UIImageView().then {
        $0.image = UIImage.mywritingTrashbinBgGradientTop
    }
    
    lazy var categoryButtton: RoundingButton = {
        let button = RoundingButton()
        button.setupRoundingButton(title: "전체 카테고리", image: "btnFilter")
        return button
    }()
    
    lazy var deleteButton: RoundingButton = {
        let button = RoundingButton()
        button.setupRoundingButton(title: "삭제", image: "btnRemove")
        button.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)
        button.tag = 2
        return button
    }()
    
    lazy var confirmButtton: RoundingButton = {
        let button = RoundingButton()
        button.setupRoundingButton(title: "확인", image: "btnCheckUnseleted")
        button.isHidden = true
        button.isEnabled = false
        button.isActivated(false)
        button.tag = 1
        return button
    }()
    
    let backgroundView = UIView().then {
        $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        $0.frame = CGRect(origin: .zero, size: CGSize(width: SizeConstants.screenWidth, height: SizeConstants.screenHeight))
    }
    
    // MARK: - Properties
    
    static let identifier = "ButtonSectionView"
    var deleteButtonIsSelected = false
    var isSelectAllowed: Bool = false
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addObservers()
        setConstraint()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    // MARK: - Methods
    
    private func setConstraint() {
        addSubviews([gradationBackground, categoryButtton, deleteButton, confirmButtton])
        
        gradationBackground.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        categoryButtton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(16 * SizeConstants.screenWidthRatio)
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
        updateConstraint()
        super.layoutSubviews()
    }
    
    func updateConstraint() {
        categoryButtton.snp.updateConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(16 * SizeConstants.screenWidthRatio)
        }
    }
    
    // MARK: - Action
    
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(confirmButtonIsActive), name: NSNotification.Name.confirmButtonIsActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(confirmButtonIsUnActive), name: NSNotification.Name.confirmButtonIsUnactive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(categoryIsChanged), name: NSNotification.Name.categoryIsChanged, object: nil)
    }
    
    @objc
    func didTapCategoryButton() {
        if categoryButtton.isSelected {
            categoryButtton.setupRoundingButton(title: "전체 카테고리", image: "btnFilter")
            categoryButtton.isActivated(false)
        } else {
            categoryButtton.setupRoundingButton(title: "서버에서", image: "btnFilterWhite")
            categoryButtton.isActivated(true)
        }
    }
    
    @objc
    func didTapDeleteButton() {
        if deleteButton.isSelected {
            deleteButton.setupRoundingButton(title: "삭제", image: "btnRemove")
            confirmButtton.isHidden = true
            confirmButtton.isActivated(false)
        } else {
            deleteButton.setupRoundingButton(title: "취소", image: "btnCancel")
            confirmButtton.isHidden = false
        }
        deleteButton.isSelected.toggle()
        NotificationCenter.default.post(name: NSNotification.Name.deleteButtonIsSelected, object: deleteButton.isSelected)
    }
    
    
    @objc func confirmButtonIsActive(noti: NSNotification) {
        confirmButtton.isActivated(true)
        confirmButtton.isSelected = true
        confirmButtton.isEnabled = true
    }
    
    @objc func confirmButtonIsUnActive(noti: NSNotification) {
        confirmButtton.isActivated(false)
        confirmButtton.isSelected = false
        confirmButtton.isEnabled = false
    }
    
    @objc func categoryIsChanged(_ sender: Notification) {
        if let filteredCategory = sender.object {
            if filteredCategory as! String == "" {
                categoryButtton.setupRoundingButton(title: "전체 카테고리", image: "btnFilter")
                categoryButtton.isActivated(false)
            } else {
                categoryButtton.setupRoundingButton(title: "\(filteredCategory)", image: "btnFilter")
                categoryButtton.isActivated(true)
            }
        }
    }
    
    // MARK: - Protocols
}

// MARK: - Extension
