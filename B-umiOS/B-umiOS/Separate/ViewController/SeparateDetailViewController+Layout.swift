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
        view.addSubviews([navigationView, navigationDividerView, detailTableView])
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

        detailTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(navigationDividerView.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }

// MARK: - Protocols
}
