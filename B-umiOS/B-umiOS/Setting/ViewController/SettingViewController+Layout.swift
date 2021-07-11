//
//  SettingViewController+Layout.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/10.
//

import UIKit

extension SettingViewController {
    //setConstraint()
    
    func setConstraint(){
        let navigationHeight = 56 + UIDevice.current.safeAreaInset.top
        
        self.view.addSubviews([navigationView, topStackView, bottomStackView, navigationDividerView, stackDividerView])
        navigationView.addSubview(headerLabel)
     
        navigationView.snp.makeConstraints { make in
            make.top.width.equalToSuperview()
            make.height.equalTo(navigationHeight * SizeConstants.screenRatio)
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
        
        let topViews = [createView(text: "삭제 휴지통 기한", items: [trashbinPeriodLabel, trashbinPeriodButton]),
                        createView(text: "분리수거함 관리", items: [trashbinManageButton]),
                        createView(text: "푸시알림", items: [pushAlarmSwitch])
                        ]
        
        for view in topViews{
            topStackView.addArrangedSubview(view)
        }

        let bottomViews = [createView(text: "서비스 이용약관", items: [serviceConditionButton]),
                           createView(text: "개인정보 처리방침", items: [personalInfomationButton]),
                           createView(text: "오픈소스 라이센스", items: [opensourceLicenseButton]),
                           createView(text: "비움 미화원 소개", items: [developerInformationButton])
                          ]
        
        for view in bottomViews{
            bottomStackView.addArrangedSubview(view)
        }
    }
}
