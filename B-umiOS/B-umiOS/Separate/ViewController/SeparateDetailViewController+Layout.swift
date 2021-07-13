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
        let navigationHeight = 56 + UIDevice.current.safeAreaInset.top
        
        self.view.addSubviews([navigationView, navigationDividerView, detailTableView])
        navigationView.addSubviews([navigationLabel, backButton])
        headerView.addSubviews([gardientBackground, confirmButton, removeButton])
        
        gardientBackground.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        removeButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16 * SizeConstants.screenRatio)
            make.centerY.equalToSuperview()
        }

        confirmButton.snp.makeConstraints { make in
            make.leading.equalTo(removeButton.snp.trailing).offset(8 * SizeConstants.screenRatio)
            make.top.equalTo(removeButton)
        }
        
        navigationLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(13 * SizeConstants.screenRatio)
        }
        
        navigationView.snp.makeConstraints { make in
            make.top.width.equalToSuperview()
            make.height.equalTo(navigationHeight * SizeConstants.screenRatio)
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

        detailTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(navigationDividerView.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }

// MARK: - Protocols
}
