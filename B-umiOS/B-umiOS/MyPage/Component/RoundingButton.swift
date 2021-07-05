//
//  RoundingButton.swift
//  B-umiOS
//
//  Created by kong on 2021/07/06.
//
import SnapKit
import UIKit

class RoundingButton: UIButton {
    
    private let buttonTitle: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let buttonImage: UIImageView = {
        var image = UIImageView()
        return image
    }()

    func setupRoundingButton(title: String, image: String) {

        self.backgroundColor = .white
        self.layer.cornerRadius = 16
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.disable.cgColor
        
        buttonTitle.text = title
        buttonTitle.textColor = .iconGray
        buttonTitle.font = .nanumSquareFont(type: .regular, size: 14)
        buttonImage.image = UIImage(named: image)
        
        let labelSize = buttonTitle.calculateLabelSize(text: title, font: buttonTitle.font)
        
        self.addSubviews([buttonTitle, buttonImage])
        
        self.snp.makeConstraints { make in
            make.width.equalTo(labelSize.width + 56)
        }
        
        buttonImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }

        buttonTitle.snp.makeConstraints { make in
            make.centerY.equalTo(buttonImage)
            make.leading.equalTo(buttonImage.snp.trailing).offset(5)
        }

    }
}
