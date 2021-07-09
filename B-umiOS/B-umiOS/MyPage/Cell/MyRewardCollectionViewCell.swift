//
//  MyRewardCollectionViewCell.swift
//  B-umiOS
//
//  Created by kong on 2021/07/09.
//

import UIKit

class MyRewardCollectionViewCell: UICollectionViewCell {
    static let identifier = "MyRewardCollectionViewCell"
    private let rewardDateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15, weight: .regular)
        $0.textColor = .pink2Main
        $0.text = "리워드받은날짜쓰"
        $0.textAlignment = .center
    }
    
    private let rewardLabel = UILabel().then {
        $0.font = .nanumSquareFont(type: .extraBold, size: 14)
        $0.textColor = .iconGray
        $0.numberOfLines = 3
        $0.text = "버들가쥣쓰는 야카나..다른 재목을 묵는 버들가짓스다."
        
        let attrString = NSMutableAttributedString(string: $0.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineSpacing = 7
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        $0.attributedText = attrString
        $0.textAlignment = .center

    }
    
    private let authorLabel = UILabel().then {
        $0.font = .nanumSquareFont(type: .extraBold, size: 14)
        $0.textColor = .black
        $0.text = "-이인애-"
        $0.textAlignment = .center
    }

    // MARK: - Properties
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews([rewardDateLabel,rewardLabel,authorLabel])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle

    // MARK: - Actions
    
    // MARK: - Methods
    
    func setConstraint() {
        rewardDateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(rewardLabel.snp.top).offset(-26)
            make.leading.trailing.equalTo(rewardLabel)
        }
        
        rewardLabel.snp.updateConstraints { make in
            make.top.equalToSuperview().inset(86)
            make.bottom.equalToSuperview().inset(83)
            make.leading.trailing.equalToSuperview().inset(17)
        }
        
        authorLabel.snp.updateConstraints { make in
            make.top.equalTo(rewardLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(17)
        }
        
        contentView.cornerRound(radius: 10)
        contentView.backgroundColor = .white
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraint()
    }
    
    // MARK: - Protocols
}
