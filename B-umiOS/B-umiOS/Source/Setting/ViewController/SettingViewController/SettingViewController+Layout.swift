//
//  SettingViewController+Layout.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/10.
//

import UIKit

extension SettingViewController {
    //setConstraint()

    func setConstraints(){
        view.addSubviews([navigationView, topStackView, bottomStackView, navigationDividerView, stackDividerView])
        navigationView.addSubview(headerLabel)
     
        navigationView.snp.makeConstraints { make in
            make.top.width.equalToSuperview()
            make.height.equalTo(SizeConstants.navigationHeight * SizeConstants.screenRatio)
        }
        
        navigationDividerView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(13 * SizeConstants.screenRatio)
        }
        
        topStackView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.width.equalToSuperview()
        }
        
        stackDividerView.snp.makeConstraints { make in
            make.top.equalTo(topStackView.snp.bottom).offset(15.5 * SizeConstants.screenRatio)
            make.leading.trailing.equalToSuperview().inset(16 * SizeConstants.screenRatio)
            make.height.equalTo(1)
        }
        
        bottomStackView.snp.makeConstraints { make in
            make.top.equalTo(stackDividerView.snp.bottom).offset(15.5 * SizeConstants.screenRatio)
            make.width.equalToSuperview()
        }
        
        let topViews = [
            createView(text: "분리수거함 관리", items: [btnLeftButton()]),
            createView(text: "푸시알림", items: [pushAlarmSwitch])
        ]
        
        for view in topViews{
            topStackView.addArrangedSubview(view)
        }
        
        let bottomViews = [
            createView(text: "서비스 이용약관", items: [btnLeftButton()]),
            createView(text: "개인정보 처리방침", items: [btnLeftButton()]),
            createView(text: "문의하기", items: [btnLeftButton()]),
            createView(text: "비움 미화원 소개", items: [btnLeftButton()])
        ]
        
        for view in bottomViews{
            bottomStackView.addArrangedSubview(view)
        }
    }
}
