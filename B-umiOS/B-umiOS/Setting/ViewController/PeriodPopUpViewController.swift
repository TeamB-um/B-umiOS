//
//  PeriodPopUpViewController.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/05.
//

import UIKit

class PeriodPopUpViewController: UIViewController {
    // MARK: - UIComponenets
    
    private let popupView = UIView().then {
        $0.cornerRound(radius: 10)
        $0.backgroundColor = .white
        $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
    }
    
    private let rect = UIView().then {
        $0.backgroundColor = .paper1
        $0.cornerRound(radius: 3)
    }
    
    private let pickerView = UIPickerView()
    
    private let confirmButton = UIButton().then {
        $0.setTitle("확인", for: .normal)
        $0.titleLabel?.font = UIFont.nanumSquareFont(type: .bold, size: 18)
        $0.tintColor = .white
        $0.backgroundColor = .blue2Main
        $0.cornerRound(radius: 10)
        $0.addTarget(self, action: #selector(didTapConfirmButton(_:)), for: .touchUpInside)
    }
    
    private let backgroundButton = UIButton().then {
        $0.addTarget(self, action: #selector(didTapBackgroundButton(_:)), for: .touchUpInside)
    }
    
    private let headerLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
        $0.textColor = .header
        $0.text = "삭제 휴지통 기간"
    }
    
    private let subLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 14)
        $0.textColor = .paper3
        $0.text = "미화원이 휴지통을 비워갈 기간을 정해주세요."
    }
    
    // MARK: - Properties

    var pickContents: [String] = ["즉시 삭제", "1일", "2일", "3일", "4일", "5일", "6일", "7일"]
    var popupdelegate: popupDelegate?
    var bgDelegate: viewDelegate?
    
    // MARK: - Initializer

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.delegate = self
        pickerView.dataSource = self
        
        setView()
        setConstraints()
    }

    // MARK: - Actions
    
    @objc private func didTapConfirmButton(_ sender: UIButton) {
        let deletePeriod = pickerView.selectedRow(inComponent: 0)
        let userInfo = UserInfo(isPush: nil, deletePeriod: deletePeriod)
        
        ActivityIndicator.shared.startLoadingAnimation()
        UserService.shared.updateUserInfo(userInfo: userInfo) { response in
            ActivityIndicator.shared.stopLoadingAnimation()
            guard let result = response as? NetworkResult<Any> else { return }
            
            switch result {
            case .success(let data):
                if let userInfoResponse = data as? GeneralResponse<UserResponse>,
                   let newUserInfo = userInfoResponse.data?.user
                {
                    UserDefaults.standard.set(newUserInfo.deletePeriod, forKey: UserDefaults.Keys.deletePeriod)
                    
                    self.popupdelegate?.sendPeriod(period: deletePeriod)
                }
            case .requestErr, .pathErr, .serverErr, .networkFail:
                /// 네트워크 에러 처리
                print("fail to update user info")
            }
        }
        
        popupdelegate?.closeBottomSheet()
        bgDelegate?.backgroundRemove()
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapBackgroundButton(_ sender: UIButton) {
        popupdelegate?.closeBottomSheet()
        bgDelegate?.backgroundRemove()
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Methods
    
    func setView() {
        view.backgroundColor = .clear
        
        let deletePeriod = UserDefaults.standard.integer(forKey: UserDefaults.Keys.deletePeriod)
        pickerView.selectRow(deletePeriod, inComponent: 0, animated: true)
    }
    
    func setConstraints() {
        view.addSubviews([backgroundButton, popupView])
        
        popupView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        backgroundButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        popupView.addSubviews([rect, headerLabel, subLabel, pickerView, confirmButton])
        
        rect.snp.makeConstraints { make in
            make.height.equalTo(6 * SizeConstants.screenRatio)
            make.leading.trailing.equalToSuperview().inset(155 * SizeConstants.screenRatio)
            make.top.equalToSuperview().offset(10 * SizeConstants.screenRatio)
            make.centerX.equalToSuperview()
        }
        
        headerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(rect.snp.bottom).offset(16 * SizeConstants.screenRatio)
            make.height.equalTo(30 * SizeConstants.screenRatio)
        }
        
        subLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headerLabel.snp.bottom).offset(8 * SizeConstants.screenRatio)
        }
        
        pickerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16 * SizeConstants.screenRatio)
            make.top.equalTo(subLabel.snp.bottom).offset(28 * SizeConstants.screenRatio)
            make.height.equalTo(140 * SizeConstants.screenRatio)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(23 * SizeConstants.screenRatio)
            make.top.equalTo(pickerView.snp.bottom).offset(32 * SizeConstants.screenRatio)
            make.bottom.equalToSuperview().inset(66 * SizeConstants.screenRatio)
            make.height.equalTo(50 * SizeConstants.screenRatio)
        }
    }
    
    // MARK: - Protocols
}

// MARK: - Extension

extension PeriodPopUpViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        pickContents[row]
    }
}

extension PeriodPopUpViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickContents.count
    }
}
