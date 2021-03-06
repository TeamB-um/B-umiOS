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
    
    private let categoryTitle: UILabel = {
        let label = UILabel()
        label.font = .nanumSquareFont(type: .regular, size: 14)
        
        return label
    }()
    
    private let writingTitle: UILabel = {
        let label = UILabel()
        label.font = .nanumSquareFont(type: .extraBold, size: 18)
        label.textColor = .black
        
        return label
    }()
    
    private let writingPriview: UILabel = {
        let label = UILabel()
        
        label.font = .nanumSquareFont(type: .regular, size: 14)
        label.textColor = .iconGray
        label.numberOfLines = 2
        
        return label
    }()
    
    let emptyCheckButton = UIButton().then {
        $0.setImage(UIImage.btnCheckEmpty, for: .normal)
        $0.isHidden = true
    }
    
    // MARK: - Properties
    static let identifier = "MyWritingCollectionViewCell"
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                emptyCheckButton.setImage(UIImage.btnCheckColor, for: .normal)
            } else {
                emptyCheckButton.setImage(UIImage.btnCheckEmpty, for: .normal)
            }
        }
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews([categoryTitle,writingTitle,writingPriview, emptyCheckButton])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle

    // MARK: - Actions
    
    // MARK: - Methods
    
    func setConstraints() {
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
        
        emptyCheckButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(16)
        }
        
        contentView.cornerRound(radius: 10)
        contentView.backgroundColor = .white
        
    }
    
    func setWritingData(data: [Writing], index: Int){
        categoryTitle.text = data[index].category.name
        categoryTitle.textColor = SeparateStyle.color[data[index].category.index]
        
        writingTitle.text = data[index].title
        writingPriview.text = data[index].text
        writingPriview.numberOfLines = 2
        writingPriview.lineSpacing(spacing: 7)
        
    }
    
    func checkButton(bool: Bool) {
        if bool {
            emptyCheckButton.isHidden = false
        } else {
            emptyCheckButton.isHidden = true
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }
    
    // MARK: - Protocols
}
