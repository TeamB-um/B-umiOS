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
    
    private let categoryButtton: UIButton = {
        let button = RoundingButton()
        button.setupRoundingButton(title: "전체 카테고리", image: "btnFilter")
        
        return button
    }()
    
    private let selectButtton: UIButton = {
        let button = RoundingButton()
        button.setupRoundingButton(title: "선택", image: "btnCheckUnseleted")
        
        return button
    }()
    
    private let deleteButton: UIButton = {
        let button = RoundingButton()
        button.setupRoundingButton(title: "삭제", image: "btnRemove")
        
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
        self.addSubviews([categoryButtton, selectButtton, deleteButton])
        
        categoryButtton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalTo(16)
        }
        
        selectButtton.snp.makeConstraints { make in
            make.centerY.equalTo(categoryButtton)
            make.leading.equalTo(categoryButtton.snp.trailing).offset(8)
            make.width.equalTo(80)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.centerY.equalTo(selectButtton)
            make.leading.equalTo(selectButtton.snp.trailing).offset(8)
            make.width.equalTo(80)
        }

    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraint()
    }
    
      // MARK: - Protocols
  }
