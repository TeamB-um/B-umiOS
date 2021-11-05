//
//  SettingSeparateViewController+Layout.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/08/05.
//

import UIKit

extension SettingSeparateViewController {
    func setConstraints() {
        view.addSubviews([navigationView, navigationDividerView, trashbinStatusLabel, trashbinStatusNumber, separateTableView])
        navigationView.addSubviews([headerLabel, backButton, addButton])
        
        navigationView.snp.makeConstraints { make in
            make.top.width.equalToSuperview()
            make.height.equalTo(SizeConstants.navigationHeight * SizeConstants.screenWidthRatio)
        }
        
        navigationDividerView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(13 * SizeConstants.screenWidthRatio)
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16 * SizeConstants.screenWidthRatio)
            make.centerY.equalTo(headerLabel)
        }
        
        addButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16 * SizeConstants.screenWidthRatio)
            make.centerY.equalTo(headerLabel)
        }
        
        trashbinStatusLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationDividerView.snp.bottom).offset(16 * SizeConstants.screenWidthRatio)
            make.leading.equalToSuperview().inset(24 * SizeConstants.screenWidthRatio)
        }
        
        trashbinStatusNumber.snp.makeConstraints { make in
            make.top.equalTo(trashbinStatusLabel)
            make.trailing.equalToSuperview().inset(28)
        }
        
        separateTableView.snp.makeConstraints { make in
            make.top.equalTo(trashbinStatusLabel.snp.bottom).offset(12)
            make.trailing.leading.bottom.equalToSuperview()
        }
    }
    
    func setTableView() {
        separateTableView.delegate = self
        separateTableView.dataSource = self
        separateTableView.backgroundColor = .background
        separateTableView.register(UINib(nibName: SeparateTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SeparateTableViewCell.identifier)
    }
}
