//
//  ThrowTrashViewController+Layout.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/09.
//

import UIKit

extension ThrowTrashViewController {
    func setConstraints() {
        navigationView.addSubviews([navigationLabel, backButton])
        explanationView.addSubviews([explanationImage, explanationLabel])
        view.addSubviews([animationView, backgroudImage, navigationView, explanationView, trash, trashBin, guideLabel])
        
        backgroudImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        animationView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
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
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(SizeConstants.navigationHeight * SizeConstants.screenRatio)
        }
        
        explanationView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(16 * SizeConstants.screenRatio)
            make.width.equalTo(328.0 * SizeConstants.screenRatio)
            make.height.equalTo(explanationView.snp.width).multipliedBy(48.0 / 328.0)
            make.centerX.equalToSuperview()
        }
        
        explanationImage.snp.makeConstraints { make in
            make.width.height.equalTo(24 * SizeConstants.screenRatio)
            make.leading.equalTo(24 * SizeConstants.screenRatio)
            make.centerY.equalToSuperview()
        }
        
        explanationLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-25 * SizeConstants.screenRatio)
            make.centerY.equalToSuperview()
        }
        
        trash.snp.makeConstraints { make in
            make.top.equalTo(explanationView.snp.bottom).offset(28 * SizeConstants.screenHeight / 812.0)
            make.width.height.equalTo(88 * SizeConstants.screenRatio)
            make.centerX.equalToSuperview()
        }
        
        guideLabel.snp.makeConstraints { make in
            make.top.equalTo(trash.snp.bottom).offset(52 * SizeConstants.screenHeight / 812.0)
            make.centerX.equalToSuperview()
        }
        
        trashBin.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-134.0 * SizeConstants.screenHeight / 812.0)
            make.width.equalToSuperview().multipliedBy(178.0 / 375.0)
            make.height.equalToSuperview().multipliedBy(0.312)
        }
    }
}
