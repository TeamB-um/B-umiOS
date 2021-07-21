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
        popupView.addSubviews([headerLabel, closeButton, monthGraphView, divideLine, entireGraphView])
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
            make.top.trailing.equalToSuperview().inset(7 * SizeConstants.screenRatio)
        }
        monthGraphView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel).offset(50)
            make.leading.trailing.equalToSuperview()
        }
        
        divideLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(18 * SizeConstants.screenRatio)
            make.height.equalTo(1)
            make.top.equalTo(monthGraphView.snp.bottom).offset(36.5 * SizeConstants.screenRatio)
        }
        
        entireGraphView.snp.makeConstraints { make in
            make.top.equalTo(divideLine.snp.bottom).offset(33.5 * SizeConstants.screenRatio)
            make.leading.trailing.equalToSuperview()
        }
    }
}
