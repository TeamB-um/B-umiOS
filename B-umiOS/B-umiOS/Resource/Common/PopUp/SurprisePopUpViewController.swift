//
//  SurprisePopUpViewController.swift
//  B-umiOS
//
//  Created by kong on 2021/08/08.
//

import UIKit

class SurprisePopUpViewController: UIViewController {
    // MARK: - UIComponenets
    
    private let popUpView = UIView().then {
        $0.backgroundColor = .white
        $0.cornerRound(radius: 10)
    }
    
    private let popUpImage = UIView().then {
        $0.backgroundColor = .blue2Main
        $0.cornerRound(radius: 10)
    }
    
    private var titleLabel = UILabel().then {
        $0.text = "깜짝 선물을 발견했어요!"
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
        $0.textColor = .black
    }
    
    private var contentLabel = UILabel().then {
        $0.text = "미화원이 휴지통 속에서 무언가\n발견했어요. 확인해볼까요?"
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 16)
        $0.textColor = .textGray
        $0.numberOfLines = 0
        $0.lineSpacing(spacing: 11)
        $0.textAlignment = .center
    }
    
    let cancelButton = UIButton().then {
        $0.cornerRound(radius: 10)
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.paper2.cgColor
        $0.setTitleColor(.paper3, for: .normal)
        $0.setTitle("닫기", for: .normal)
        $0.titleLabel?.font = UIFont.nanumSquareFont(type: .bold, size: 18)
        $0.addTarget(self, action: #selector(didTapCloseButton(_:)), for: .touchUpInside)
    }
    
    let confirmButton = UIButton().then {
        $0.cornerRound(radius: 10)
        $0.backgroundColor = .blue2Main
        $0.tintColor = .white
        $0.setTitle("보러가기", for: .normal)
        $0.titleLabel?.font = UIFont.nanumSquareFont(type: .bold, size: 18)
        $0.isEnabled = false
    }
    
    private var bottomButtonStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.alignment = .fill
        $0.spacing = 13
        $0.axis = .horizontal
    }
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    init(writing: Writing) {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setConstraints()
    }

    // MARK: - Actions
    
    @objc func didTapCloseButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Methods
    
    func setConstraints() {
        view.addSubviews([popUpView, popUpImage, titleLabel, contentLabel, bottomButtonStackView])
        bottomButtonStackView.addArrangedSubview(cancelButton)
        bottomButtonStackView.addArrangedSubview(confirmButton)
        
        popUpView.snp.makeConstraints {
            $0.width.equalTo(343 * SizeConstants.screenRatio)
            $0.height.equalTo(438 * SizeConstants.screenRatio)
            $0.center.equalToSuperview()
        }
        
        popUpImage.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(popUpView)
            $0.height.equalTo(popUpView.snp.height).multipliedBy(0.5)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(popUpImage.snp.bottom).offset(19)
            $0.centerX.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(bottomButtonStackView.snp.top).offset(-26)
        }
        
        bottomButtonStackView.snp.makeConstraints {
            $0.leading.trailing.equalTo(popUpView).inset(24)
            $0.bottom.equalTo(popUpView).inset(20)
            $0.height.equalTo(50 * SizeConstants.screenRatio)
        }
        
    }
    
    func setView() {
        view.layer.backgroundColor = UIColor.black.withAlphaComponent(0.5).cgColor
    }
    

    // MARK: - Protocols
}
