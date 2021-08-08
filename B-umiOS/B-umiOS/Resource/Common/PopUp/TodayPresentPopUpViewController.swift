//
//  TodayPresentPopUpViewController.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/08/08.
//

import UIKit

class TodayPresentPopUpViewController: UIViewController {
    // MARK: - UIComponenets
    
    let popUpView = UIView().then {
        $0.backgroundColor = .white
        $0.cornerRound(radius: 10)
    }
    
    let mainLabel = UILabel().then {
        $0.text = "오늘의 선물"
        $0.textAlignment = .center
        $0.textColor = .header
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
    let presentImageView = UIImageView().then {
        $0.image = UIImage(systemName: "graduationcap.fill")
        $0.tintColor = .red
    }
    
    let dividerView = UIView().then {
        $0.backgroundColor = UIColor(red: 227 / 255.0, green: 227 / 255.0, blue: 227 / 255.0, alpha: 1)
    }
    
    lazy var presentLabel = UILabel().then {
        $0.textColor = .textGray
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    lazy var closeButton = UIButton().then {
        $0.setImage(UIImage.btnCloseBlack, for: .normal)
    }
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    init(content: String) {
        super.init(nibName: nil, bundle: nil)
        
        presentLabel.text = content
        presentLabel.lineSpacing(spacing: 11)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view != popUpView {
            dismiss(animated: true, completion: nil)
        }
    }

    // MARK: - Actions
    
    // MARK: - Methods
    
    func setConstraints() {
        popUpView.addSubviews([closeButton, mainLabel, presentImageView, dividerView, presentLabel])
        view.addSubview(popUpView)
        
        popUpView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(343.0 / 375.0)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(4 * SizeConstants.screenRatio)
            make.trailing.equalToSuperview().inset(4 * SizeConstants.screenRatio)
            make.width.height.equalTo(SizeConstants.screenRatio * 48)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(52)
            make.centerX.equalToSuperview()
        }
        
        presentImageView.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(43)
            make.width.equalToSuperview().multipliedBy(298.0 / 375.0)
            make.height.equalTo(presentImageView.snp.width).multipliedBy(168.0 / 298.0)
            make.centerX.equalToSuperview()
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(presentImageView.snp.bottom).offset(22.5)
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview().inset(15)
            make.centerX.equalToSuperview()
        }
        
        presentLabel.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(31.5)
            make.leading.trailing.equalToSuperview().inset(40)
            make.bottom.equalToSuperview().offset(-31)
        }
    }
    
    // MARK: - Protocols
}
