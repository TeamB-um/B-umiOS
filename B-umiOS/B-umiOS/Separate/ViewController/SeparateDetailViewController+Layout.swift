//
//  SeparateDetailViewController+Layout.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/08.
//

import UIKit

extension SeparateDetailViewController {
    // MARK: - Methods
    
    func setConstraint(){
        view.addSubviews([navigationView, navigationDividerView, removeButton, checkButton, detailTableView])
        navigationView.addSubviews([navigationLabel, backButton])
        
        navigationLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.width.equalToSuperview()
            make.height.equalTo(64 * SizeConstants.ScreenRatio)
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(19 * SizeConstants.ScreenRatio)
            make.centerY.equalTo(navigationLabel)
        }
        
        navigationDividerView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        checkButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16 * SizeConstants.ScreenRatio)
            make.top.equalTo(navigationDividerView.snp.bottom).offset(16 * SizeConstants.ScreenRatio)
        }

        removeButton.snp.makeConstraints { make in
            make.trailing.equalTo(checkButton.snp.leading).offset(-8 * SizeConstants.ScreenRatio)
            make.top.equalTo(checkButton)
        }

        detailTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(checkButton.snp.bottom).offset(8 * SizeConstants.ScreenRatio)
            make.bottom.equalToSuperview()
        }
    }

// MARK: - Protocols
}
