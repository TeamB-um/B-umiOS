//
//  CategoryTagCollectionViewCell.swift
//  B-umiOS
//
//  Created by kong on 2021/07/08.
//

import UIKit

class CategoryTagCollectionViewCell: UICollectionViewCell {
    // MARK: - UIComponenets
    
    static let identifier = "CategoryTagCollectionViewCell"
    
    var TagList: [String] = ["","","",""]
    
    private let tagButton: RoundingButton = {
        var button = RoundingButton()
        button.setupRoundingButton(title: "인간관계조까")
        return button
    }()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(tagButton)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    override func prepareForReuse() {
        isSelected = false
    }
    
    
    func setConstraint() {
        tagButton.snp.updateConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraint()
    }
    
}

