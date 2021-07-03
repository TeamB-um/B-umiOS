//
//  MyPageMenuCollectionViewCell.swift
//  B-umiOS
//
//  Created by kong on 2021/07/04.
//

import UIKit

class MyPageMenuCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "MyPageMenuCollectionViewCell"
    
    private let menuTitle: UILabel = {
        let label = UILabel()
        label.font = .nanumSquareFont(type: .extraBold, size: 20)
        
        return label
    }()
    
    override var isSelected: Bool {
        willSet {
            if newValue {
                menuTitle.textColor = .blue2Main
            } else {
                menuTitle.textColor = .disable
            }
        }
    }
    
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(menuTitle)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    override func prepareForReuse() {
        isSelected = false
    }
    
    
    func setCell(menu: String) {
        menuTitle.text = menu
        menuTitle.textAlignment = .center
        menuTitle.sizeToFit()
        menuTitle.font = .nanumSquareFont(type: .extraBold, size: 20)
    }
    
    func setConstraint() {
        menuTitle.snp.updateConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraint()
    }
    
}

