//
//  CompletionMessage.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/13.
//

import UIKit

class CompletionMessage: UIView {
    // MARK: - UIComponenets

    private lazy var logoImage = UIImageView()
    
    private lazy var messageLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
        $0.textColor = .white
    }
    
    // MARK: - Initializer
    
    init(image: UIImage, message: String) {
        super.init(frame: .zero)
        
        logoImage.image = image
        messageLabel.text = message
        
        setView()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    // MARK: - Actions
    
    // MARK: - Methods
    
    func setView() {
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
    }
    
    func setConstraints() {
        addSubviews([logoImage, messageLabel])
        
        logoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(318.0).multipliedBy(318.0 / 812.0)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(147.0 / 375.0)
            make.height.equalTo(logoImage.snp.width).multipliedBy(102.0 / 147.0)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Protocols
}
