//
//  SeparateViewController+layout.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/06.
//

import UIKit

extension SeparateViewController {
    func setConstraint(){
        let navigationHeight = 56 + UIDevice.current.safeAreaInset.top
        
        self.view.addSubviews([navigationView, navigationDividerView, explanationView, separateCollectionView])
        
        navigationView.addSubviews([navigationLabel, graphButton])
            
        navigationView.snp.makeConstraints { make in
            make.top.width.equalToSuperview()
            make.height.equalTo(navigationHeight * SizeConstants.screenRatio)
        }
        
        navigationLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(13 * SizeConstants.screenRatio)
        }
        
        graphButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-8 * SizeConstants.screenRatio)
            make.width.height.equalTo(36 * SizeConstants.screenRatio)
            make.centerY.equalTo(navigationLabel)
        }
        
        navigationDividerView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        explanationView.addSubviews([explanationLabel])
        
        explanationView.snp.makeConstraints { make in
            make.top.equalTo(navigationDividerView.snp.bottom).offset(16 * SizeConstants.screenRatio)
            make.leading.trailing.equalToSuperview().inset(24 * SizeConstants.screenRatio)
            make.height.equalTo(48 * SizeConstants.screenRatio)
        }

        explanationLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        separateCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(explanationView.snp.bottom).offset(24 * SizeConstants.screenRatio)
            make.bottom.equalToSuperview()
        }
    }
}
