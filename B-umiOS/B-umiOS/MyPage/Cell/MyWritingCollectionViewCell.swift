//
//  MyWritingCollectionViewCell.swift
//  B-umiOS
//
//  Created by kong on 2021/07/04.
//

import SnapKit
import UIKit

class MyWritingCollectionViewCell: UICollectionViewCell {
    // MARK: - UIComponenets
    
    static let identifier = "MyWritingCollectionViewCell"
    
    private let categoryTitle: UILabel = {
        let label = UILabel()
        label.font = .nanumSquareFont(type: .regular, size: 14)
        label.textColor = .pink2Main
        label.text = "카테고리"
        
        return label
    }()
    
    private let writingTitle: UILabel = {
        let label = UILabel()
        label.font = .nanumSquareFont(type: .extraBold, size: 18)
        label.textColor = .black
        label.text = "글제목"
        
        return label
    }()
    
    private let writingPriview: UILabel = {
        let label = UILabel()
        
        label.font = .nanumSquareFont(type: .regular, size: 14)
        label.textColor = .iconGray
        label.numberOfLines = 2
        label.text = "대충 글내용 미리보기어쩌고저쩌고대충 글내용 미리보기 어쩌고저쩌고"
        
        let attrString = NSMutableAttributedString(string: label.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineSpacing = 7
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        label.attributedText = attrString
        
        return label
    }()
    // MARK: - Properties
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews([categoryTitle,writingTitle,writingPriview])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle

    // MARK: - Actions
    
    // MARK: - Methods
    
    func setConstraint() {
        categoryTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview().inset(17)
        }
        
        writingTitle.snp.updateConstraints { make in
            make.top.equalTo(categoryTitle.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(17)
        }
        
        writingPriview.snp.updateConstraints { make in
            make.top.equalTo(writingTitle.snp.bottom).offset(7)
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
