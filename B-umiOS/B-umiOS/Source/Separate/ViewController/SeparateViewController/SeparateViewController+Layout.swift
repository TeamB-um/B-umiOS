//
//  SeparateViewController+layout.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/06.
//

import UIKit

extension SeparateViewController {
    func setConstraints(){
        view.addSubviews([navigationView, navigationDividerView,separateCollectionView])
        
        navigationView.addSubviews([navigationLabel, graphButton])
        
        navigationView.snp.makeConstraints { make in
            make.top.width.equalToSuperview()
            make.height.equalTo(SizeConstants.navigationHeight * SizeConstants.screenWidthRatio)
        }
        
        navigationLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(13 * SizeConstants.screenWidthRatio)
        }
        
        graphButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-8 * SizeConstants.screenWidthRatio)
            make.width.height.equalTo(36 * SizeConstants.screenWidthRatio)
            make.centerY.equalTo(navigationLabel)
        }
        
        navigationDividerView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        separateCollectionView.snp.makeConstraints { make in
            make.top.equalTo(navigationDividerView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
