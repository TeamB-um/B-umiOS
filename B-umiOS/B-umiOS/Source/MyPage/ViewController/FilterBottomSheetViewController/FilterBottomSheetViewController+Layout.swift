//
//  FilterBottomSheetViewController+Layout.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/08/05.
//

import UIKit

extension FilterBottmSheetViewController {
    func setConstraints() {
        view.addSubviews([backgroundButton, popupView])
        popupView.addSubviews([rect, categoryTagCollecitonView, categoryLabel, settingPeriodView, setDateLabel, dateSwitch, confirmButton])
        settingPeriodView.addSubviews([datePickerView, startDateButton, endDateButton, startDateLine, endDateLine, startLabel, endLabel])
        
        backgroundButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        popupView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.top.equalTo(setDateLabel.snp.top).offset(-40)
            make.leading.trailing.equalToSuperview()
        }
        
        rect.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.width.equalToSuperview().multipliedBy(65.0/375.0)
            make.centerX.equalToSuperview()
            make.height.equalTo(6 * SizeConstants.screenWidthRatio)
        }
        confirmButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(42)
            make.height.equalTo(50)
        }
        
        categoryTagCollecitonView.snp.makeConstraints { make in
            make.height.equalTo(180)
            make.bottom.equalTo(confirmButton.snp.top).offset(30)
            make.leading.trailing.equalTo(confirmButton)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.bottom.equalTo(categoryTagCollecitonView.snp.top).offset(-22)
            make.leading.equalTo(confirmButton)
        }
        
        settingPeriodView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(categoryLabel.snp.top).offset(-34)
            make.height.equalTo(0)
        }
        
        startLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(startDateLine).offset(8)
        }
        
        endLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(endDateLine).offset(8)
        }
        
        startDateButton.snp.makeConstraints { make in
            make.top.equalTo(startLabel.snp.bottom).offset(3)
            make.leading.equalTo(startLabel)
            make.height.equalTo(28)
        }
        
        endDateButton.snp.makeConstraints { make in
            make.top.equalTo(endLabel.snp.bottom).offset(3)
            make.leading.equalTo(endLabel)
            make.height.equalTo(28)
        }
        
        startDateLine.snp.makeConstraints { make in
            make.top.equalTo(startDateButton.snp.bottom)
            make.leading.equalToSuperview()
            make.width.equalTo((SizeConstants.screenWidth - 55)/2)
            make.height.equalTo(2)
        }
        
        endDateLine.snp.makeConstraints { make in
            make.top.equalTo(endDateButton.snp.bottom)
            make.width.equalTo((SizeConstants.screenWidth - 55)/2)
            make.trailing.equalToSuperview()
            make.height.equalTo(2)
        }
        
        datePickerView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(140)
        }
        
        setDateLabel.snp.makeConstraints { make in
            make.leading.equalTo(confirmButton)
            make.bottom.equalTo(settingPeriodView.snp.top).offset(-24)
        }
        
        dateSwitch.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalTo(setDateLabel)
        }
    }
}
