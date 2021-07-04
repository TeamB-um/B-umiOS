//
//  SettingViewController.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/02.
//

import UIKit

class SettingViewController: UIViewController {
    // MARK: - UIComponenets

    private var headerView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private var headerLabel = UILabel().then {
        $0.text = "설정"
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
    }
    
    private var topStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.spacing = 21
        $0.axis = .vertical
    }
    
    private var bottomStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.spacing = 21
        $0.axis = .vertical
    }
    
    private var trashbinPeriodLabel = UILabel().then {
        $0.text = "3일"
        $0.textColor = .textGray
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 16)
    }
    
    private var trashbinPeriodButton = UIButton().then {
        $0.setImage(UIImage(named: "brnEdit"), for: .normal)
    }
    
    private var trashbinManageButton = UIButton().then {
        $0.setImage(UIImage(named: "btnLeft"), for: .normal)
        $0.addTarget(self, action: #selector(didTapTrashBinManageButton(_:)), for: .touchUpInside)
    }
    
    private var pushAlarmSwitch = UISwitch().then {
        $0.onTintColor = .blue2Main
    }
    
    private var serviceConditionButton = UIButton().then {
        $0.setImage(UIImage(named: "btnLeft"), for: .normal)
    }
    
    private var personalInfomationButton = UIButton().then {
        $0.setImage(UIImage(named: "btnLeft"), for: .normal)
    }
    
    private var opensourceLicenseButton = UIButton().then {
        $0.setImage(UIImage(named: "btnLeft"), for: .normal)
    }
    
    private var developerInformationButton = UIButton().then {
        $0.setImage(UIImage(named: "btnLeft"), for: .normal)
    }

    // MARK: - Properties
    
    // MARK: - Initializer

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .background
        setConstraint()
    }

    // MARK: - Actions

    @objc
        private func didTapTrashBinManageButton(_ sender: UIButton) {
            if let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "SettingTrashBinViewController"){
                self.navigationController?.pushViewController(pushVC, animated: true)
            }
        }
    // MARK: - Methods
    
    func setConstraint(){
        let line1 = makeLine()
        let line2 = makeLine()
        
        self.view.addSubviews([headerView,topStackView, bottomStackView,line1,line2])
        headerView.addSubview(headerLabel)
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(self.view)
            make.width.equalToSuperview()
        }
        
        line1.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headerView).inset(62)
            make.bottom.equalTo(headerView).inset(18)
        }
        
        topStackView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(19)
            make.width.equalToSuperview()
        }
        
        line2.snp.makeConstraints { make in
            make.top.equalTo(topStackView.snp.bottom).offset(17.5)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }
        
        bottomStackView.snp.makeConstraints { make in
            make.top.equalTo(line2.snp.bottom).offset(18.5)
            make.width.equalToSuperview()
        }
        
        let topViews = [createView(text: "삭제 휴지통 기한", items: [trashbinPeriodLabel, trashbinPeriodButton]),
                        createView(text: "휴지통 관리", items: [trashbinManageButton]),
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
    
    func createView(text : String, items: [NSCoding]) -> UIView{
        let newView = UIView()
        let label = UILabel()
        newView.backgroundColor = .background
        label.textColor = .paper4
        label.text = text
        label.font = UIFont.nanumSquareFont(type: .regular, size: 16)
        newView.addSubview(label)
        
        let stackView = UIStackView().then {
            $0.distribution = .fillEqually
            $0.spacing = 15
            $0.axis = .horizontal
        }
        newView.addSubview(stackView)
        

        for item in items{
            stackView.addArrangedSubview(item as! UIView)
        }
        
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview()
        }

        stackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(24)
            make.top.bottom.equalTo(label)
        }
        return newView
    }
    
    func makeLine()-> UIView{
        return UIView().then {
            $0.backgroundColor = UIColor(white: 237.0 / 255.0, alpha: 1.0)
        }
    }
    
    
    // MARK: - Protocols
}
