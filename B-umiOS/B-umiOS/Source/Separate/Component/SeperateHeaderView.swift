//
//  SeperateSectionView.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/12.
//

import Foundation
import UIKit

class SeperateHeaderView: UICollectionReusableView {
    // MARK: - UIComponenets
    
    let explanationView = UIView().then {
        $0.backgroundColor = .background
        $0.cornerRound(radius: 10)
        $0.setShadow(radius: 13, offset: CGSize(width: 1, height: 4) , opacity: 0.1, color: .black)
    }
    
    let explanationLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 14)
        $0.textColor = .iconGray
        let attributedStr = NSMutableAttributedString(string: "쓰레기가 꽉 차면 미화원이 비워갈게요!")

        attributedStr.addAttribute(.foregroundColor, value: UIColor.blue3, range: ("쓰레기가 꽉 차면 미화원이 비워갈게요!" as NSString).range(of: "쓰레기"))

        $0.attributedText = attributedStr
    }
    
    let seperateImage = UIImageView().then {
        $0.image = UIImage.toastPaper1
    }
    
    let gardientBackground = UIImageView().then {
        $0.image = UIImage.separateBgGradientTop
    }
    
    // MARK: - Properties
    
    static let identifier = "SeperateSectionView"
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions

    // MARK: - Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setConstraints()
    }
        
    func setConstraints(){
        self.addSubviews([gardientBackground, explanationView])
        
        gardientBackground.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        explanationView.addSubviews([seperateImage, explanationLabel])
        
        
        explanationView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16 * SizeConstants.screenRatio)
            make.bottom.equalToSuperview().inset(8 * SizeConstants.screenRatio)
            make.leading.trailing.equalToSuperview().inset(24 * SizeConstants.screenRatio)
            make.height.equalTo(48 * SizeConstants.screenRatio)
        }
        
        seperateImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(25 * SizeConstants.screenRatio)
        }
        
        explanationLabel.snp.makeConstraints { make in
            make.leading.equalTo(seperateImage.snp.trailing).offset(27 * SizeConstants.screenRatio)
            make.centerY.equalToSuperview()
        }
    }
}
