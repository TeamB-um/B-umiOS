//
//  SettingSeparateViewController+Layout.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/08/05.
//

import UIKit

extension SettingSeparateViewController {
    func setConstraints() {
        view.addSubviews([navigationView, trashbinStatusLabel, trashbinStatusNumber, separateTableView])
        navigationView.addSubview(addButton)
        
        navigationView.snp.makeConstraints { make in
            make.top.width.equalToSuperview()
            make.height.equalTo(SizeConstants.navigationHeight)
        }
        
        addButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16 * SizeConstants.screenWidthRatio)
            make.width.equalTo(36 * SizeConstants.screenWidthRatio)
            make.height.equalTo(36 * SizeConstants.screenHeightRatio)
            make.bottom.equalToSuperview().offset(-10 * SizeConstants.screenHeightRatio)
        }
        
        trashbinStatusLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(16 * SizeConstants.screenHeightRatio)
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
