//
//  PeriodPopUpViewController+Layout.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/08/05.
//

import UIKit

extension PeriodPopUpViewController {
    func setConstraints() {
        view.addSubviews([backgroundButton, popupView])
        
        popupView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        backgroundButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        popupView.addSubviews([rect, headerLabel, subLabel, pickerView, confirmButton])
        
        rect.snp.makeConstraints { make in
            make.height.equalTo(6 * SizeConstants.screenRatio)
            make.leading.trailing.equalToSuperview().inset(155 * SizeConstants.screenRatio)
            make.top.equalToSuperview().offset(10 * SizeConstants.screenRatio)
            make.centerX.equalToSuperview()
        }
        
        headerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(rect.snp.bottom).offset(16 * SizeConstants.screenRatio)
            make.height.equalTo(30 * SizeConstants.screenRatio)
        }
        
        subLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headerLabel.snp.bottom).offset(8 * SizeConstants.screenRatio)
        }
        
        pickerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16 * SizeConstants.screenRatio)
            make.top.equalTo(subLabel.snp.bottom).offset(28 * SizeConstants.screenRatio)
            make.height.equalTo(140 * SizeConstants.screenRatio)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(23 * SizeConstants.screenRatio)
            make.top.equalTo(pickerView.snp.bottom).offset(32 * SizeConstants.screenRatio)
            make.bottom.equalToSuperview().inset(66 * SizeConstants.screenRatio)
            make.height.equalTo(50 * SizeConstants.screenRatio)
        }
    }
}
