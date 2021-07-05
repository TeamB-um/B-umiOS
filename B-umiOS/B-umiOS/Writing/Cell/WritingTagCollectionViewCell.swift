//
//  WrtingTagCollectionViewCell.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/05.
//

import UIKit

class WritingTagCollectionViewCell: UICollectionViewCell {
    static let identifier = "WrtingTagCollectionViewCell"
    
    // MARK: - UIComponenets
    
    private let tagLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 16)
    }
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setCell()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func layoutSubviews() {
        setConstraints()
        
        contentView.cornerRound(radius: 20)
    }
    
    // MARK: - Actions
    
    // MARK: - Methods
    
    func setCell() {
        contentView.backgroundColor = UIColor.disable
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.textGray.cgColor
    }
    
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
    
    // MARK: - Protocols
}
