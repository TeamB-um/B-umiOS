//
//  CompletionMessage.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/13.
//

import UIKit

class CompletionMessage: UIView {
    // MARK: - UIComponenets

    private lazy var logoImage = UIImageView().then {
        $0.image = UIImage(named: self.logo)
    }
    
    private lazy var messageLabel = UILabel().then {
        $0.text = self.message
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
        $0.textColor = .white
    }
    
    // MARK: - Properties
    
    var message: String
    var logo: String
    
    // MARK: - Initializer
    
    init(image: String, message: String) {
        self.logo = image
        self.message = message
        
        super.init(frame: .zero)
        
        setView()
        setConstraint()
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
    
    func setConstraint() {
        addSubviews([logoImage, messageLabel])
        
        logoImage.snp.makeConstraints { make in
            make.top.equalTo(326 * SizeConstants.screenRatio)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(147.0 / 375.0)
            make.height.equalTo(logoImage.snp.width).multipliedBy(102.0 / 147.0)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Protocols
}
