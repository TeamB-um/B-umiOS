//
//  WritingViewController+layout.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/06.
//

import UIKit

extension WritingViewController {
    func setConstraint() {
        navigationView.addSubviews([navigationLabel, backButton, checkButton])
        view.addSubviews([navigationView, navigationDividerView, settingButton, guideImage, guideLabel, tagCollectionView, dividerView, titleTextField, textFieldCountLabel, textFieldDividerView, textView])
        
        let screenSize = UIScreen.main.bounds
        
        navigationLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8 * screenSize.width / 375)
            make.width.height.equalTo(36 * screenSize.width / 375)
            make.centerY.equalToSuperview()
        }
        
        checkButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-8 * screenSize.width / 375)
            make.width.height.equalTo(36 * screenSize.width / 375)
            make.centerY.equalToSuperview()
        }
        
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.width.equalToSuperview()
            make.height.equalTo(64 * screenSize.width / 375)
        }
        
        navigationDividerView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        settingButton.snp.makeConstraints { make in
            make.top.equalTo(navigationDividerView.snp.bottom).offset(7.5 * screenSize.width / 375)
            make.leading.equalToSuperview().offset(2 * screenSize.width / 375)
            make.width.height.equalTo(48 * screenSize.width / 375)
        }
        
        guideImage.snp.makeConstraints { make in
            make.leading.equalTo(settingButton.snp.trailing).offset(6 * screenSize.width / 375)
            make.centerY.equalTo(settingButton.snp.centerY)
        }
        
        guideLabel.snp.makeConstraints { make in
            make.leading.equalTo(guideImage.snp.trailing).offset(3 * screenSize.width / 375)
            make.centerY.equalTo(guideImage.snp.centerY)
        }
        
        tagCollectionView.snp.makeConstraints { make in
            make.top.equalTo(navigationDividerView.snp.bottom)
            make.leading.equalTo(settingButton.snp.trailing).offset(6 * screenSize.width / 375)
            make.trailing.equalToSuperview()
            make.height.equalTo(64 * screenSize.width / 375)
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(tagCollectionView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(24 * screenSize.width / 375)
            make.height.equalTo(48 * screenSize.width / 375)
        }

        textFieldDividerView.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(16 * screenSize.width / 375)
            make.height.equalTo(1)
        }

        textFieldCountLabel.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom)
            make.centerY.equalTo(titleTextField.snp.centerY)
            make.trailing.equalToSuperview().inset(24 * screenSize.width / 375)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(textFieldDividerView.snp.bottom).offset(19.5)
            make.leading.trailing.equalTo(textFieldDividerView)
            make.bottom.equalToSuperview().offset(-48)
        }
    }
}
