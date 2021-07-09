//
//  SeparateGraphPopUpViewController+Layout.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/09.
//

import UIKit

extension SeparateGraphPopUpViewController {

    // MARK: - Constraint
    func setConstraint(){
        self.view.addSubviews([backgroundButton,popupView])
        popupView.addSubviews([headerLabel, monthView])
        popupView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(80 * SizeConstants.screenRatio)
            make.leading.trailing.equalToSuperview().inset(16 * SizeConstants.screenRatio)
        }
        
        backgroundButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        headerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(19 * SizeConstants.screenRatio)
        }
        
        monthView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel).offset(50)
            make.leading.trailing.equalToSuperview()
        }
    }
}
