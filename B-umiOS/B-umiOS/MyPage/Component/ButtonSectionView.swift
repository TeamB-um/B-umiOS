//
//  ButtonSectionView.swift
//  B-umiOS
//
//  Created by kong on 2021/07/05.
//

import SnapKit
import UIKit

class ButtonSectionView: UIView {
    // MARK: - UIComponenets
    
    private let filterButton: UIButton = {
        let button = UIButton()

        button.backgroundColor = .white
        //모서리 굴곡률
        button.layer.cornerRadius = 16
        //테두리 굵기
        button.layer.borderWidth = 1
        //테두리 색상
        button.layer.borderColor = UIColor.disable.cgColor
        
        return button
    }()
    
    private let filterButtonTitle: UILabel = {
        let label = UILabel()
        
        label.text = "전체 카테고리"
        label.textColor = .disable
        label.font = .nanumSquareFont(type: .regular, size: 14)
        
        return label
    }()
    
    private let filterButtonImage: UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: "btnCheckUnseleted")
        
        return image
    }()
    
    private let selectButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        
        return button
    }()
    
    private let closeButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .yellow
        
        return button
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        
        return button
    }()
      // MARK: - Properties
      
      // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //code
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
        //storyboard
    }

      // MARK: - Actions
      
      // MARK: - Methods
    
    private func setConstraint(){
        self.addSubviews([filterButton, filterButtonTitle, filterButtonImage])
        
        filterButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
        
        filterButtonImage.snp.makeConstraints { make in
            make.center.equalTo(filterButton)
            make.leading.equalTo(filterButton).offset(16)
        }
        
        filterButtonTitle.snp.makeConstraints { make in
            make.center.equalTo(filterButton)
            make.leading.equalTo(filterButtonImage).offset(5)
        }

    }
    
    func setButton(){
        
    }
    
      // MARK: - Protocols
  }
