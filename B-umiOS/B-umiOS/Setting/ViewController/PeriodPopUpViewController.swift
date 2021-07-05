//
//  PeriodPopUpViewController.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/05.
//

import UIKit

class PeriodPopUpViewController: UIViewController{

    // MARK: - UIComponenets
    
    private let popupView = UIView().then {
        $0.cornerRound(radius: 10)
        $0.backgroundColor = .white
        $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
    }
    
    private let pickerView = UIPickerView()
    
    private let confirmButton = UIButton().then {
        $0.setTitle("확인", for: .normal)
        $0.titleLabel?.font = UIFont.nanumSquareFont(type: .bold, size: 18)
        $0.tintColor = .white
        $0.backgroundColor = .blue2Main
        $0.cornerRound(radius: 10)
    }
    
    private  let backgroundButton = UIButton().then {
        $0.addTarget(self, action: #selector(didTapBackgroundButton(_:)), for: .touchUpInside)
    }
    
    private let headerLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
        $0.textColor = .header
        $0.text = "삭제 휴지통 기간"
    }
    
    private let subLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 14)
        $0.textColor = .paper3
        $0.text = "미화원이 휴지통을 비워갈 기간을 정해주세요."
    }
    // MARK: - Properties
    var pickContents : [String] = ["즉시 삭제", "1일", "2일", "3일", "4일", "5일", "6일", "7일", "8일", "9일"]
    
    var popupdelegate : popupDelegate?
    
    // MARK: - Initializerpopupdelegate

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        setConstraint()
    }
    
    // MARK: - Actions
    
    @objc private func didTapBackgroundButton(_ sender: UIButton) {
        popupdelegate?.diss()
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Methods
    
    func setConstraint() {
        let rect = UIView().then {
            $0.backgroundColor = .paper1
            $0.clipsToBounds = true
            $0.cornerRound(radius: 10)
        }
        
        self.view.addSubviews([backgroundButton,popupView])
        
        popupView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        backgroundButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        popupView.addSubviews([rect,headerLabel,subLabel,pickerView,confirmButton])
        
        rect.snp.makeConstraints { make in
            make.height.equalTo(8)
            make.width.equalTo(65)
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
        }
        
        headerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(rect.snp.bottom).offset(16)
            make.height.equalTo(30)
        }
        
        subLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headerLabel.snp.bottom).offset(8)
        }
        
        pickerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(subLabel.snp.bottom).offset(28)
            make.height.equalTo(140)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(23)
            make.top.equalTo(pickerView.snp.bottom).offset(32)
            make.bottom.equalToSuperview().inset(66)
            make.height.equalTo(50)
        }
        
    }
    // MARK: - Protocols
}

// MARK: - Extension

extension PeriodPopUpViewController : UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickContents[row]
    }
}

extension PeriodPopUpViewController : UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return pickContents.count
    }
}
