//
//  WrtingTagCollectionViewCell.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/05.
//

import UIKit

class WritingTagCollectionViewCell: UICollectionViewCell {
    static let identifier = "WritingTagCollectionViewCell"
    
    // MARK: - UIComponenets
    
    private let tagLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 16)
    }
    
    // MARK: - Properties
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                tagLabel.textColor = .header
                
                contentView.backgroundColor = UIColor(red: 183/255, green: 227/255, blue: 205/255, alpha: 1)
                contentView.layer.borderColor = UIColor(red: 143/255, green: 212/255, blue: 177/255, alpha: 1).cgColor
            } else {
                tagLabel.textColor = .paper3
                
                contentView.backgroundColor = .disable
                contentView.layer.borderColor = UIColor.textGray.cgColor
            }
        }
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isSelected = false
        contentView.layer.borderWidth = 1.0
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setConstraints()
        contentView.cornerRound(radius: 19)
    }
    
    override func prepareForReuse() {
        isSelected = false
        
        updateConstraint()
    }
    
    // MARK: - Actions
    
    // MARK: - Methods
    
    func setTagLabel(tag: String) {
        tagLabel.text = tag
        tagLabel.sizeToFit()
    }
    
    func setConstraints() {
        contentView.addSubviews([tagLabel])
        
        tagLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func updateConstraint() {
        tagLabel.snp.updateConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    // MARK: - Protocols
}
