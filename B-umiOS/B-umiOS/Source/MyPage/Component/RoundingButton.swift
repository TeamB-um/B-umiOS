//
//  RoundingButton.swift
//  B-umiOS
//
//  Created by kong on 2021/07/06.
//
import SnapKit
import UIKit

class RoundingButton: UIButton {
    // MARK: - UIComponenets
    
    private let buttonTitle: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let buttonImage: UIImageView = {
        var imageview = UIImageView()
        return imageview
    }()
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - Methods

    func setupRoundingButton(title: String, image: String) {
        self.layer.cornerRadius = 16
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.disable.cgColor
        self.backgroundColor = .white
        self.addSubviews([buttonTitle, buttonImage])
        
        buttonTitle.text = title
        buttonTitle.font = .nanumSquareFont(type: .regular, size: 14)
        buttonImage.tintColor = .iconGray
        buttonImage.image = UIImage(named: image)?.withRenderingMode(.alwaysTemplate)
        buttonTitle.textColor = .iconGray
        
        buttonImage.snp.updateConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
        buttonTitle.snp.updateConstraints { make in
            make.centerY.equalTo(buttonImage)
            make.leading.equalTo(buttonImage.snp.trailing).offset(5)
            make.trailing.equalToSuperview().inset(16)
        }
    }
    
    func isActivated(_ isSelected : Bool){
        if(isSelected){
            buttonTitle.textColor = .white
            buttonImage.tintColor = .white
            self.backgroundColor = .blue2Main
        }
        else{
            buttonTitle.textColor = .iconGray
            buttonImage.tintColor = .iconGray
            self.backgroundColor = .white
        }
    }
}
