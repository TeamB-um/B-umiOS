//
//  WritingPopUpViewController+Layout.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/08/05.
//

import UIKit

extension WritingPopUpViewController {
    func setConstraints() {
        view.addSubview(popUpView)
        popUpView.addSubviews([closeButton, titleLabel, guideLabel, deleteButton, archiveButton])
        
        popUpView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(343.0 / 375.0)
            make.height.equalTo(popUpView.snp.width).multipliedBy(226.0 / 343.0)
            make.center.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.width.height.equalTo(48 * SizeConstants.screenRatio)
            make.top.equalToSuperview().inset(4 * SizeConstants.screenRatio)
            make.trailing.equalToSuperview().inset(8 * SizeConstants.screenRatio)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(28 * SizeConstants.screenRatio)
            make.centerX.equalToSuperview()
        }
        
        guideLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(14 * SizeConstants.screenRatio)
            make.centerX.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24 * SizeConstants.screenRatio)
            make.bottom.equalToSuperview().offset(-32 * SizeConstants.screenRatio)
            make.width.equalTo(141 * SizeConstants.screenRatio)
            make.height.equalTo(50 * SizeConstants.screenRatio)
        }
        
        archiveButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-24 * SizeConstants.screenRatio)
            make.bottom.equalToSuperview().offset(-32 * SizeConstants.screenRatio)
            make.width.equalTo(141 * SizeConstants.screenRatio)
            make.height.equalTo(50 * SizeConstants.screenRatio)
        }
    }
}
