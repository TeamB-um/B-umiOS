//
//  SeparateViewController+layout.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/06.
//

import UIKit

extension SeparateViewController {
    func setConstraint(){
        view.addSubviews([navigationView, navigationDividerView, explanationView, separateCollectionView])
        navigationView.addSubviews([navigationLabel, graphButton])
        
        let screenSize = UIScreen.main.bounds
    
        navigationLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.width.equalToSuperview()
            make.height.equalTo(64 * screenSize.width / 375)
        }
        
        graphButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-8 * screenSize.width / 375)
            make.width.height.equalTo(36 * screenSize.width / 375)
            make.centerY.equalToSuperview()
        }
        
        navigationDividerView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        explanationView.addSubviews([explanationLabel])
        
        explanationView.snp.makeConstraints { make in
            make.top.equalTo(navigationDividerView.snp.bottom).offset(16 * screenSize.width / 375)
            make.leading.trailing.equalToSuperview().inset(24 * screenSize.width / 375)
            make.height.equalTo(48 * screenSize.width / 375)
        }

        explanationLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        separateCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(explanationView.snp.bottom).offset(24 * screenSize.width / 375)
            make.bottom.equalToSuperview()
        }
    }
}
