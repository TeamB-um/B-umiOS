//
//  SettingViewController.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/02.
//

import MessageUI
import SafariServices
import UIKit

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
        self.setView()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setUserInfo()
        UNUserNotificationCenter.current().getNotificationSettings(completionHandler: self.myNotificationSettingsCompletionHandler)
    }
    
    // MARK: - Actions
    
    @objc
    private func touchInside(_ sender: TapGesture) {
        switch sender.identifier {
        case "분리수거함 관리":
            if let pushVC = self.storyboard?.instantiateViewController(withIdentifier: SettingSeparateViewController.identifier) {
                self.navigationController?.pushViewController(pushVC, animated: true)
            }
        case "푸시알림":
            break
        case "서비스 이용약관":
            self.present(SFSafariViewController(url: SettingInfo.serviceURL), animated: true, completion: nil)
        case "개인정보 처리방침":
            self.present(SFSafariViewController(url: SettingInfo.personalInfoURL), animated: true, completion: nil)
        case "문의하기":
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients([SettingInfo.biumEmail])
                mail.setMessageBody("", isHTML: true)

                present(mail, animated: true)
            }
        case "오픈소스 라이센스":
            self.navigationController?.pushViewController(OpenSourceViewController(), animated: true)
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
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    // MARK: - Methods
    
    func setView() {
        view.backgroundColor = .background
    }
    
    func createView(text: String, items: [NSCoding]) -> UIView {
        let tapGesture = TapGesture(target: self, action: #selector(self.touchInside(_:)))
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
            $0.spacing = 16 * SizeConstants.screenWidthRatio
        }
        
        newView.addSubviews([label, stackView])
        
        for item in items {
            stackView.addArrangedSubview(item as! UIView)
        }
        
        newView.snp.makeConstraints { make in
            make.height.equalTo(48 * SizeConstants.screenWidthRatio)
        }
        
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(24 * SizeConstants.screenWidthRatio)
            make.centerY.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(24)
            make.top.bottom.equalTo(label)
        }
        
        return newView
    }
    
    func setUserInfo() {
        let deletePeriod = UserDefaults.standard.integer(forKey: UserDefaults.Keys.deletePeriod)
        self.trashbinPeriodLabel.text = "\(deletePeriod)일"
    }
    
    func myNotificationSettingsCompletionHandler(settings: UNNotificationSettings) {
        DispatchQueue.main.async {
            self.pushAlarmSwitch.isOn = settings.authorizationStatus == .authorized ? true : false
        }
    }
    
    func btnLeftButton() -> UIButton {
        let button = UIButton().then {
            $0.setImage(UIImage.btnLeft, for: .normal)
            $0.isEnabled = false
        }
        return button
    }
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

extension SettingViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
