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
    
    private let selectButtton: RoundingButton = {
        let button = RoundingButton()
        button.setupRoundingButton(title: "선택", image: "btnCheckUnseleted")
        button.addTarget(self, action: #selector(didTapSelectButtton(_:)), for: .touchUpInside)
        
        return button
    }()
    
    private let deleteButton: RoundingButton = {
        let button = RoundingButton()
        button.setupRoundingButton(title: "삭제", image: "btnRemove")
        button.addTarget(self, action: #selector(didTapDeleteButton(_:)), for: .touchUpInside)
        button.isHidden = true
        
        return button
    }()

      // MARK: - Properties
      
      // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
        //storyboard
    }

      // MARK: - Actions
    
    
      
      // MARK: - Methods
    
    private func setConstraint(){
        self.addSubviews([gradationBackground, categoryButtton, selectButtton, deleteButton])
        
        gradationBackground.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        categoryButtton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(16 * SizeConstants.screenRatio)
            make.width.equalTo(137)
        }
        
        selectButtton.snp.makeConstraints { make in
            make.centerY.equalTo(categoryButtton)
            make.leading.equalTo(categoryButtton.snp.trailing).offset(8)
            make.width.equalTo(80)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.centerY.equalTo(categoryButtton)
            make.leading.equalTo(selectButtton.snp.trailing).offset(8)
            make.width.equalTo(80)
        }
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraint()
    }
    
    // MARK: - Action
    
    @objc
    private func didTapAddButton(_ sender: UIButton) {
            let popUpVC =  FilterBottmSheetViewController()
            popUpVC.modalPresentationStyle = .overFullScreen
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
    func didTapSelectButtton(_ sender: UIButton) {
        if selectButtton.isSelected {
            selectButtton.setupRoundingButton(title: "선택", image: "btnCheckUnseleted", selected: true)
            deleteButton.isHidden = true
        } else {
            selectButtton.setupRoundingButton(title: "취소", image: "btnClose", selected: false)
            deleteButton.isHidden = false
        }
    }
    
    @objc
    func didTapDeleteButton(_ sender: UIButton) {

    }
    
      // MARK: - Protocols
  }
