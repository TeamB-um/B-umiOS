//
//  MyRewardCollectionViewCell.swift
//  B-umiOS
//
//  Created by kong on 2021/07/09.
//

import UIKit

class MyRewardCollectionViewCell: UICollectionViewCell {
    // MARK: - UIComponenets
    
    private lazy var myRewardView = UIImageView().then {
        $0.image = UIImage(named: "")
    }
    private let rewardDateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15, weight: .regular)
        $0.textColor = .white
    }
    
    private let rewardLabel = UILabel().then {
        $0.font = .nanumSquareFont(type: .extraBold, size: 14)
        $0.textColor = .white
        $0.numberOfLines = 3
        $0.lineBreakMode = .byTruncatingTail
    }
    
    private let authorLabel = UILabel().then {
        $0.font = .nanumSquareFont(type: .extraBold, size: 14)
        $0.textColor = .white
    }

    // MARK: - Properties
    
    static let identifier = "MyRewardCollectionViewCell"
    var myRewardBackground: [String] = ["0","1","2","3","4","5","6","7"]
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews([myRewardView,rewardDateLabel,rewardLabel,authorLabel])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle

    // MARK: - Actions
    
    // MARK: - Methods
    
    func setConstraint() {
        myRewardView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
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
            make.top.equalTo(rewardLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(17)
        }
        
        contentView.cornerRound(radius: 10)
        contentView.backgroundColor = .white
    }
    
    func setData(data:[Reward], index: Int){
        
        let writtenDate = Date().ISOStringToDate(date: data[index].createdDate ?? "")
        let date = Date().ISODateToString(format: "yyyy.MM.dd(E)", date: writtenDate)
        self.rewardDateLabel.text = date
        
        rewardDateLabel.textAlignment = .center
        
        authorLabel.text = data[index].author
        authorLabel.textAlignment = .center
        authorLabel.lineBreakMode = .byTruncatingTail
        
        rewardLabel.text = data[index].sentence
        rewardLabel.lineSpacing(spacing: 7)
        rewardLabel.textAlignment = .center
        
        myRewardView.image = UIImage(named: "\(data[index].index)")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraint()
    }
    
    // MARK: - Protocols
}
