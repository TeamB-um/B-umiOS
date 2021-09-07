//
//  SettingViewController.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/02.
//

import UIKit
import SafariServices

protocol popupDelegate {
    func closeBottomSheet()
    func sendData<T>(data: T)
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
    
    lazy var pushAlarmSwitch = UISwitch().then {
        $0.onTintColor = .blue2Main
        $0.addTarget(self, action: #selector(didTapPushSwitch(_:)), for: .valueChanged)
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
    private func touchInside(_ sender: TapGesture){
        switch sender.identifier {
        case "분리수거함 관리" :
            if let pushVC = self.storyboard?.instantiateViewController(withIdentifier: SettingSeparateViewController.identifier) {
                self.navigationController?.pushViewController(pushVC, animated: true)
            }
        case "푸시알림" :
            break
        case "서비스 이용약관":
            self.present(SFSafariViewController(url: URL(string: "https://buttery-hockey-3d6.notion.site/5d286495dc4b46a79938864aa21fa6f6")!), animated: true, completion: nil)
        case "개인정보 처리방침" :
            self.present(SFSafariViewController(url: URL(string: "https://buttery-hockey-3d6.notion.site/e3127bcf5d034b57aebd7a466918002c")!), animated: true, completion: nil)
        case "오픈소스 라이센스" :
            break
        case "비움 미화원 소개" :
            break
        default:
            break
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
        let tapGesture = TapGesture(target: self, action: #selector(touchInside(_:)))
        tapGesture.identifier = text
        
        let newView = UIView().then {
            $0.backgroundColor = .background
            $0.addGestureRecognizer(tapGesture)
            $0.isUserInteractionEnabled = true
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

    func btnLeftButton() -> UIButton {
        let button = UIButton().then {
            $0.setImage(UIImage.btnLeft, for: .normal)
            $0.isEnabled = false
        }
        return button
    }
    // MARK: - Protocols
}

// MARK: - Extension

extension SettingViewController: popupDelegate {
    func closeBottomSheet() {
        self.backgroundView.removeFromSuperview()
    }
    
    func sendData<T>(data: T) {
        self.trashbinPeriodLabel.text = "\(data)일"
    }
}

