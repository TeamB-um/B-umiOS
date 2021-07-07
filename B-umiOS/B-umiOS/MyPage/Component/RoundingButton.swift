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

    func setupRoundingButton(title: String, image: String, selected: Bool) {

        self.layer.cornerRadius = 16
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.disable.cgColor
        
        buttonTitle.text = title
        buttonTitle.font = .nanumSquareFont(type: .regular, size: 14)
        buttonImage.image = UIImage(named: image)
        
        let labelSize = buttonTitle.calculateLabelSize(text: title, font: buttonTitle.font)

        self.snp.remakeConstraints { make in
            make.width.equalTo(labelSize.width + 56)
        }
        if selected {
            self.backgroundColor = .white
            buttonTitle.textColor = .iconGray
        } else {
            self.backgroundColor = .blue2Main
            buttonTitle.textColor = .white
        }
        isSelected.toggle()
    }
    
    func setupRoundingButton(title: String, image: String) {
        let labelSize = buttonTitle.calculateLabelSize(text: title, font: buttonTitle.font)

        self.layer.cornerRadius = 16
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.disable.cgColor
        self.backgroundColor = .white
        self.addSubviews([buttonTitle, buttonImage])
        
        buttonTitle.text = title
        buttonTitle.font = .nanumSquareFont(type: .regular, size: 14)
        buttonImage.image = UIImage(named: image)
        buttonTitle.textColor = .iconGray
        
        self.snp.remakeConstraints { make in
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
