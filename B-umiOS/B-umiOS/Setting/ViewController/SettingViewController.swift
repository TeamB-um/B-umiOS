//
//  SettingViewController.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/02.
//

import UIKit

protocol popupDelegate {
    func closeBottomSheet()
    func sendPeriod(period: Int)
}

class SettingViewController: UIViewController {
    // MARK: - UIComponenets

    var navigationView = UIView().then {
        $0.backgroundColor = .white
    }
    
    var backgroundView = UIView().then {
        $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        $0.frame = CGRect(origin: .zero, size: CGSize(width: SizeConstants.screenWidth, height: SizeConstants.screenHeight))
    }
    
    var headerLabel = UILabel().then {
        $0.text = "설정"
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
    }
    
    let navigationDividerView = UIView().then {
        $0.backgroundColor = .paper1
    }
    
    let stackDividerView = UIView().then {
        $0.backgroundColor = .paper1
    }
    
    var topStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.axis = .vertical
    }
    
    var bottomStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.axis = .vertical
    }
    
    var trashbinPeriodLabel = UILabel().then {
        $0.text = "3일"
        $0.textColor = .textGray
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 16)
    }
    
    let trashbinPeriodButton = UIButton().then {
        $0.setImage(UIImage.brnEdit, for: .normal)
        $0.addTarget(self, action: #selector(setPeriodButton(_:)), for: .touchUpInside)
    }
    
    let trashbinManageButton = UIButton().then {
        $0.setImage(UIImage.btnLeft, for: .normal)
        $0.addTarget(self, action: #selector(didTapTrashBinManageButton(_:)), for: .touchUpInside)
    }
    
    lazy var pushAlarmSwitch = UISwitch().then {
        $0.onTintColor = .blue2Main
        $0.addTarget(self, action: #selector(didTapPushSwitch(_:)), for: .valueChanged)
    }
    
    let serviceConditionButton = UIButton().then {
        $0.setImage(UIImage.btnLeft, for: .normal)
    }
    
    let personalInfomationButton = UIButton().then {
        $0.setImage(UIImage.btnLeft, for: .normal)
    }
    
    let opensourceLicenseButton = UIButton().then {
        $0.setImage(UIImage.btnLeft, for: .normal)
    }
    
    let developerInformationButton = UIButton().then {
        $0.setImage(UIImage.btnLeft, for: .normal)
    }

    // MARK: - Properties
    
    // MARK: - Initializer

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUserInfo()
    }

    // MARK: - Actions

    @objc
    private func didTapTrashBinManageButton(_ sender: UIButton) {
        if let pushVC = self.storyboard?.instantiateViewController(withIdentifier: SettingSeparateViewController.identifier) {
            self.navigationController?.pushViewController(pushVC, animated: true)
        }
    }
    
    @objc
    private func setPeriodButton(_ sender: UIButton) {
        let popUpVC = self.storyboard?.instantiateViewController(identifier: "PeriodPopUpViewController") as! PeriodPopUpViewController
        popUpVC.modalPresentationStyle = .overFullScreen
        popUpVC.modalTransitionStyle = .coverVertical
        popUpVC.popupdelegate = self
        
        let window = UIApplication.shared.windows.first
        window?.addSubview(self.backgroundView)
        
        self.present(popUpVC, animated: true, completion: nil)
    }
    
    @objc
    private func didTapPushSwitch(_ sender: UISwitch) {
        let userInfo = UserInfo(isPush: sender.isOn, deletePeriod: nil)
        
        ActivityIndicator.shared.startLoadingAnimation()
        UserService.shared.updateUserInfo(userInfo: userInfo) { response in
            ActivityIndicator.shared.stopLoadingAnimation()
            
            guard let result = response as? NetworkResult<Any> else { return }
            
            switch result {
            case .success(let data):
                if let userInfoResponse = data as? GeneralResponse<UserResponse>,
                   let newUserInfo = userInfoResponse.data?.user
                {
                    UserDefaults.standard.set(newUserInfo.isPush, forKey: UserDefaults.Keys.isPush)
                }
            case .requestErr, .pathErr, .serverErr, .networkFail:
                /// 네트워크 에러 처리
                print("fail to update user info")
            }
        }
    }

    // MARK: - Methods
    
    func setView() {
        view.backgroundColor = .background
    }
    
    func createView(text: String, items: [NSCoding]) -> UIView {
        let newView = UIView().then {
            $0.backgroundColor = .background
        }
    
        let label = UILabel().then {
            $0.textColor = .paper4
            $0.text = text
            $0.font = UIFont.nanumSquareFont(type: .regular, size: 16)
        }
        
        let stackView = UIStackView().then {
            $0.distribution = .fillEqually
            $0.axis = .horizontal
            $0.spacing = 16 * SizeConstants.screenRatio
        }
        
        newView.addSubviews([label, stackView])
        
        for item in items {
            stackView.addArrangedSubview(item as! UIView)
        }
        
        newView.snp.makeConstraints { make in
            make.height.equalTo(48 * SizeConstants.screenRatio)
        }
        
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(24 * SizeConstants.screenRatio)
            make.centerY.equalToSuperview()
        }

        stackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(24)
            make.top.bottom.equalTo(label)
        }
        
        return newView
    }
    
    func setUserInfo() {
        let isPush = UserDefaults.standard.bool(forKey: UserDefaults.Keys.isPush)
        let deletePeriod = UserDefaults.standard.integer(forKey: UserDefaults.Keys.deletePeriod)
        
        self.pushAlarmSwitch.isOn = isPush
        self.trashbinPeriodLabel.text = "\(deletePeriod)일"
    }

    // MARK: - Protocols
}

// MARK: - Extension

extension SettingViewController: popupDelegate {
    func closeBottomSheet() {
        self.backgroundView.removeFromSuperview()
    }
    
    func sendPeriod(period: Int) {
        self.trashbinPeriodLabel.text = "\(period)일"
    }
}
