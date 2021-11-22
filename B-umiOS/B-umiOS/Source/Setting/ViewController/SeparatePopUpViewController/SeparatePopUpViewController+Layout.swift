//
//  SeparatePopUpViewController+Layout.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/08/05.
//

import UIKit

extension SeparatePopUpViewController {
    func setConstraints() {
        view.addSubviews([backgroundButton, popupView])

        popupView.addSubviews([headerLabel, subLabel, textField, stackView, textNumberLabel, boilerLabel])
        
        popupView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(343.0 / 375.0)
            make.height.equalTo(popupView.snp.width).multipliedBy(271.0 / 343.0)
            make.center.equalToSuperview()
        }
        
        backgroundButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        headerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(32 * SizeConstants.screenWidthRatio)
        }

        subLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(70 * SizeConstants.screenWidthRatio)
        }

        textField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24 * SizeConstants.screenWidthRatio)
            make.top.equalTo(subLabel.snp.bottom).offset(34 * SizeConstants.screenWidthRatio)
            make.height.equalTo(40 * SizeConstants.screenWidthRatio)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(28 * SizeConstants.screenWidthRatio)
            make.leading.trailing.equalToSuperview().inset(24 * SizeConstants.screenWidthRatio)
            make.bottom.equalToSuperview().inset(32 * SizeConstants.screenWidthRatio)
            make.height.equalTo(50 * SizeConstants.screenWidthRatio)
        }
        
        textNumberLabel.snp.makeConstraints { make in
            make.centerY.equalTo(textField)
            make.trailing.equalToSuperview().inset(36)
        }

        boilerLabel.snp.makeConstraints { make in
            make.centerY.equalTo(textNumberLabel)
            make.trailing.equalTo(textNumberLabel.snp.leading).offset(-8 * SizeConstants.screenWidthRatio)
        }
        stackView.addArrangedSubview(cancelButton)
        stackView.addArrangedSubview(confirmButton)
    }
}
