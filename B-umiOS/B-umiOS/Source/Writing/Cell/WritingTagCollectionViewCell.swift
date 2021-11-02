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
                tagLabel.textColor = .blue3
                tagLabel.font = .nanumSquareFont(type: .bold, size: 16)
                
                contentView.backgroundColor = .blue0
                contentView.layer.borderColor = UIColor.blue2Main.cgColor
            } else {
                tagLabel.textColor = .iconGray
                tagLabel.font = .nanumSquareFont(type: .regular, size: 16)
                
                contentView.backgroundColor = .paper1
                contentView.layer.borderColor = UIColor.paper1.cgColor
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
        contentView.cornerRounds()
    }
    
    override func prepareForReuse() {
        isSelected = false
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
    
    // MARK: - Protocols
}
