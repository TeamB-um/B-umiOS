//
//  ThrowTrashViewController+Layout.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/09.
//

import UIKit

extension ThrowTrashViewController {
    func setConstraints() {
        let navigationHeight = 56 + UIDevice.current.safeAreaInset.top
        
        navigationView.addSubviews([navigationLabel, backButton])
        explanationView.addSubviews([explanationImage, explanationLabel])
        view.addSubviews([navigationView, explanationView, trash, trashBin, guideLabel])
        
        navigationLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-13)
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8 * SizeConstants.screenRatio)
            make.width.height.equalTo(36 * SizeConstants.screenRatio)
            make.bottom.equalToSuperview().offset(-10)
        }

        navigationView.snp.makeConstraints { make in
            make.top.width.equalToSuperview()
            make.height.equalTo(navigationHeight * SizeConstants.screenRatio)
        }
        
        explanationView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(16 * SizeConstants.screenRatio)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(48 * SizeConstants.screenRatio)
        }
        
        explanationImage.snp.makeConstraints { make in
            make.width.height.equalTo(24 * SizeConstants.screenRatio)
            make.leading.equalTo(24 * SizeConstants.screenRatio)
            make.centerY.equalToSuperview()
        }
        
        explanationLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-27 * SizeConstants.screenRatio)
            make.centerY.equalToSuperview()
        }
        
        trash.snp.makeConstraints { make in
            make.top.equalTo(explanationView.snp.bottom).offset(28 * SizeConstants.screenRatio)
            make.width.height.equalTo(88 * SizeConstants.screenRatio)
            make.centerX.equalToSuperview()
        }
        
        guideLabel.snp.makeConstraints { make in
            make.top.equalTo(trash.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        trashBin.snp.makeConstraints { make in
            make.top.equalTo(trash.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(400 * SizeConstants.screenRatio)
        }
    }
}
