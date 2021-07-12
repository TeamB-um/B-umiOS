//
//  SeperateSectionView.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/12.
//

import Foundation
import UIKit

class SeperateSectionView: UICollectionReusableView {
    // MARK: - UIComponenets
    
    let explanationView = UIView().then {
        $0.backgroundColor = .clear
        $0.cornerRound(radius: 10)
        $0.setShadow(radius: 13, offset: CGSize(width: 1, height: 4) , opacity: 0.1, color: .black)
    }
    
    let explanationLabel = UILabel().then {
        $0.text = "당신이 보관한 스트레스입니다."
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 14)
        let attributedStr = NSMutableAttributedString(string: "당신이 보관한 스트레스입니다.")

        attributedStr.addAttribute(.foregroundColor, value: UIColor.blue3, range: ("당신이 보관한 스트레스입니다." as NSString).range(of: "스트레스"))

        $0.attributedText = attributedStr
    }
    
    let gardientBackground = UIImageView().then {
        $0.image = UIImage(named: "separateBgGradientTop")
    }
    
    // MARK: - Properties
    
    // MARK: - Initializer
    static let identifier = "SeperateSectionView"
    
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
        setConstraint()
    }
        
    func setConstraint(){
        self.addSubviews([gardientBackground, explanationView, explanationLabel])
        
        gardientBackground.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        explanationView.addSubviews([explanationLabel])
        
        
        explanationView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16 * SizeConstants.screenRatio)
            make.bottom.equalToSuperview().inset(8 * SizeConstants.screenRatio)
            make.leading.trailing.equalToSuperview().inset(24 * SizeConstants.screenRatio)
            make.height.equalTo(48 * SizeConstants.screenRatio)
        }

        explanationLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
