//
//  WritingViewController+layout.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/06.
//

import UIKit

extension WritingViewController {
    func setConstraints() {
        navigationView.addSubviews([navigationLabel, backButton, checkButton])
        view.addSubviews([navigationView, navigationDividerView, guideImage, guideLabel, tagCollectionView, leftGradientView, righrGradientView, settingButton, dividerView, titleTextField, textFieldCountLabel, textFieldDividerView, textView])
   
        navigationLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(backButton.snp.centerY)
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8 * SizeConstants.screenRatio)
            make.width.height.equalTo(36 * SizeConstants.screenRatio)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        checkButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-8 * SizeConstants.screenRatio)
            make.width.height.equalTo(36 * SizeConstants.screenRatio)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        navigationView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(SizeConstants.navigationHeight * SizeConstants.screenRatio)
        }
        
        navigationDividerView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        settingButton.snp.makeConstraints { make in
            make.top.equalTo(navigationDividerView.snp.bottom).offset(7.5 * SizeConstants.screenRatio)
            make.leading.equalToSuperview().offset(2 * SizeConstants.screenRatio)
            make.width.height.equalTo(48 * SizeConstants.screenRatio)
        }
        
        guideImage.snp.makeConstraints { make in
            make.leading.equalTo(settingButton.snp.trailing).offset(6 * SizeConstants.screenRatio)
            make.centerY.equalTo(settingButton.snp.centerY)
        }
        
        guideLabel.snp.makeConstraints { make in
            make.leading.equalTo(guideImage.snp.trailing).offset(3 * SizeConstants.screenRatio)
            make.centerY.equalTo(guideImage.snp.centerY)
        }
        
        tagCollectionView.snp.makeConstraints { make in
            make.top.equalTo(navigationDividerView.snp.bottom)
            make.leading.equalTo(settingButton.snp.trailing).offset(6 * SizeConstants.screenRatio)
            make.trailing.equalToSuperview()
            make.height.equalTo(64 * SizeConstants.screenRatio)
        }
        
        leftGradientView.snp.makeConstraints { make in
            make.top.equalTo(navigationDividerView.snp.bottom)
            make.leading.equalToSuperview()
            make.width.equalTo(100 * SizeConstants.screenRatio)
            make.bottom.equalTo(dividerView.snp.bottom)
        }
        
        righrGradientView.snp.makeConstraints { make in
            make.top.equalTo(navigationDividerView.snp.bottom)
            make.trailing.equalToSuperview()
            make.width.equalTo(44 * SizeConstants.screenRatio)
            make.bottom.equalTo(dividerView.snp.bottom)
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(tagCollectionView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(24 * SizeConstants.screenRatio)
            make.height.equalTo(48 * SizeConstants.screenRatio)
        }

        textFieldDividerView.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(16 * SizeConstants.screenRatio)
            make.height.equalTo(1)
        }

        textFieldCountLabel.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom)
            make.centerY.equalTo(titleTextField.snp.centerY)
            make.trailing.equalToSuperview().inset(24 * SizeConstants.screenRatio)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(textFieldDividerView.snp.bottom).offset(19.5)
            make.leading.trailing.equalTo(textFieldDividerView)
            make.bottom.equalToSuperview().offset(-48)
        }
    }
}
