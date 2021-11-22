//
//  MyRewardPopUpViewController+Layout.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/08/05.
//

extension MyRewardPopUpViewController {
    func setConstraints() {
        view.addSubviews([popUpView])
        popUpView.addSubviews([backgroundImageView, rewardLabel, closeButton, dateLabel, titleLabel, authorLabel, subRewardLabel, logoImage])
        
        popUpView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(343 * SizeConstants.screenWidthRatio)
            make.height.equalTo(593 * SizeConstants.screenWidthRatio)
        }
        
        backgroundImageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        rewardLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(23 * SizeConstants.screenWidthRatio)
            make.centerX.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(4 * SizeConstants.screenWidthRatio)
            make.trailing.equalToSuperview().inset(4 * SizeConstants.screenWidthRatio)
            make.width.height.equalTo(48 * SizeConstants.screenWidthRatio)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(rewardLabel.snp.bottom).offset(10 * SizeConstants.screenWidthRatio)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(191 * SizeConstants.screenWidthRatio)
            make.bottom.equalToSuperview().inset(317 * SizeConstants.screenWidthRatio)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(35)
            make.centerX.equalToSuperview()
        }
        
        subRewardLabel.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp.bottom).offset(78 * SizeConstants.screenWidthRatio)
            make.bottom.equalTo(logoImage.snp.top).offset( -65 * SizeConstants.screenWidthRatio)
            make.leading.trailing.equalToSuperview().inset(63 * SizeConstants.screenWidthRatio)
        }
        
        logoImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(19 * SizeConstants.screenWidthRatio)
            make.bottom.equalToSuperview().inset(28 * SizeConstants.screenWidthRatio)
        }
    }
}
