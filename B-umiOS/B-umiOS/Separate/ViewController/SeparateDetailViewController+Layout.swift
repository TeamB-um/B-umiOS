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
        view.addSubviews([navigationView, navigationDividerView, confirmButton, removeButton, detailTableView])
        navigationView.addSubviews([navigationLabel, backButton])
        
        navigationLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.width.equalToSuperview()
            make.height.equalTo(64 * SizeConstants.screenRatio)
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(19 * SizeConstants.screenRatio)
            make.centerY.equalTo(navigationLabel)
        }
        
        navigationDividerView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        removeButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16 * SizeConstants.screenRatio)
            make.top.equalTo(navigationDividerView.snp.bottom).offset(16 * SizeConstants.screenRatio)
        }

        confirmButton.snp.makeConstraints { make in
            make.leading.equalTo(removeButton.snp.trailing).offset(8 * SizeConstants.screenRatio)
            make.top.equalTo(removeButton)
        }

        detailTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(removeButton.snp.bottom).offset(8 * SizeConstants.screenRatio)
            make.bottom.equalToSuperview()
        }
    }

// MARK: - Protocols
}
