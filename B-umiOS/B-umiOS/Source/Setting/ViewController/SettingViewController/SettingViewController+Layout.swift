//
//  SettingViewController+Layout.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/10.
//

import UIKit

extension SettingViewController {
    func setConstraints() {
        view.addSubviews([navigationView, topStackView, bottomStackView, stackDividerView])
     
        navigationView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(SizeConstants.navigationHeight)
        }
        
        topStackView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.width.equalToSuperview()
        }
        
        stackDividerView.snp.makeConstraints { make in
            make.top.equalTo(topStackView.snp.bottom).offset(15.5 * SizeConstants.screenWidthRatio)
            make.leading.trailing.equalToSuperview().inset(16 * SizeConstants.screenWidthRatio)
            make.height.equalTo(1)
        }
        
        bottomStackView.snp.makeConstraints { make in
            make.top.equalTo(stackDividerView.snp.bottom).offset(15.5 * SizeConstants.screenWidthRatio)
            make.width.equalToSuperview()
        }
        
        let topViews = [
            createView(text: "분리수거함 관리", items: [btnLeftButton()]),
            createView(text: "푸시알림", items: [pushAlarmSwitch])
        ]
        
        for view in topViews {
            topStackView.addArrangedSubview(view)
        }
        
        let bottomViews = [
            createView(text: "서비스 이용약관", items: [btnLeftButton()]),
            createView(text: "개인정보 처리방침", items: [btnLeftButton()]),
            createView(text: "문의하기", items: [btnLeftButton()]),
            createView(text: "오픈소스 라이센스", items: [btnLeftButton()])
        ]
        
        for view in bottomViews {
            bottomStackView.addArrangedSubview(view)
        }
    }
}
