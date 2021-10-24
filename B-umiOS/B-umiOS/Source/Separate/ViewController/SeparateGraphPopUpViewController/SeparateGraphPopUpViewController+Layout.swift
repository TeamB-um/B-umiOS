//
//  SeparateGraphPopUpViewController+Layout.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/09.
//

import UIKit

extension SeparateGraphPopUpViewController {
    // MARK: - Constraint
    
    func setConstraints(){
        view.addSubviews([backgroundButton,popupView])
        
        popupView.addSubviews([headerLabel, closeButton, graphStackView, divideLine])
        
        popupView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(80 * SizeConstants.screenRatio)
            make.leading.trailing.equalToSuperview().inset(16 * SizeConstants.screenRatio)
        }
        
        backgroundButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        headerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(23 * SizeConstants.screenRatio)
        }
        
        closeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(7 * SizeConstants.screenRatio)
            make.top.equalToSuperview().inset(7 * SizeConstants.screenHeight / 812.0)
        }
        
        graphStackView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        divideLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(18 * SizeConstants.screenRatio)
            make.centerY.equalTo(graphStackView)
            make.height.equalTo(1)
        }
    }
}
