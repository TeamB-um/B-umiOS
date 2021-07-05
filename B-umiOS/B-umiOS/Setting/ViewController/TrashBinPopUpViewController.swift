//
//  TrashBinPopUpViewController.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/05.
//

import UIKit

class TrashBinPopUpViewController: UIViewController {
    // MARK: - UIComponenets
    
    private let popupView = UIView().then {
        $0.cornerRound(radius: 10)
        $0.backgroundColor = .white
    }
    
    private  let backgroundButton = UIButton().then {
        $0.addTarget(self, action: #selector(didTapBackgroundButton(_:)), for: .touchUpInside)
    }
    
    private lazy var headerLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
        $0.textColor = .header
        $0.text = headerText
    }
        
    private lazy var subLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 16)
        $0.textColor = .paper3
        $0.text = subText
    }
    
    private lazy var textfield = UITextField().then {
        $0.placeholder = placeholder
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 14)
        $0.textColor = .header
        $0.borderStyle = .roundedRect
    }
    
    private lazy var textNumberLabel = UILabel().then {
        $0.textColor = .green2Main
        $0.text = "0/6"
    }
    
    private let cancelButton = UIButton().then {
        $0.cornerRound(radius: 10)
        $0.backgroundColor = .lightGray
        $0.layer.borderWidth = 1
        $0.tintColor = .iconGray
        $0.layer.borderColor = UIColor.paper2.cgColor
        $0.setTitle("취소", for: .normal)
    }
    
    private let confirmButton = UIButton().then {
        $0.cornerRound(radius: 10)
        $0.backgroundColor = .blue2Main
        $0.tintColor = .white
        $0.setTitle("확인", for: .normal)
    }
    
    private var stackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.spacing = 13
        $0.axis = .horizontal
    }
    
    // MARK: - Properties
    
    var headerText : String = "header view"
    var subText : String = "sub view"
    var placeholder : String = "placeholder"
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        setConstraint()
    }
    
    // MARK: - Actions
    
    @objc  private func didTapBackgroundButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Methods
    
    func setConstraint() {
        
        self.view.addSubviews([backgroundButton,popupView])

        popupView.addSubviews([headerLabel,subLabel,textfield,stackView,textNumberLabel])
        popupView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(238)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        backgroundButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        headerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(32)
        }

        subLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headerLabel.snp.bottom).offset(8)
        }

        textfield.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(subLabel.snp.bottom).offset(28)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalTo(textfield.snp.bottom).offset(28)
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(32)
            make.height.equalTo(50)
        }
        
        textNumberLabel.snp.makeConstraints { make in
            make.centerY.equalTo(textfield)
            make.trailing.equalToSuperview().inset(36)
        }

        stackView.addArrangedSubview(cancelButton)
        stackView.addArrangedSubview(confirmButton)
    }
    
    // MARK: - Protocols
}
