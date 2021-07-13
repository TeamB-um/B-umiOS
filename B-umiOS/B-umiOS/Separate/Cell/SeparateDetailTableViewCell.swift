//
//  SeparateDetailTableViewCell.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/08.
//

import UIKit

class SeparateDetailTableViewCell: UITableViewCell {
    // MARK: - UIComponenets
  
    var mainView = UIView().then {
        $0.backgroundColor = .white
        $0.cornerRound(radius: 10)
        $0.setShadow(radius: 10, offset: CGSize(width: 0, height: 4), opacity: 0.25, color: .paper2)
    }
    
    var titleLabel = UILabel().then {
        $0.text = "제목"
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 18)
    }
    
    var previewLabel = UILabel().then {
        $0.text = "미리보기미리보기미리보기미리보기"
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 14)
    }
    
    lazy var checkButton = UIButton().then {
        $0.setImage(UIImage(named: "btnCheckEmpty"), for: .normal)
    }
    
    // MARK: - Properites
    
    static let identifier = "SeparateDetailTableViewCell"
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                print("check")
                checkButton.setImage(UIImage(named: "btnCheckColor"), for: .normal)
            } else {
                print("empty")
                checkButton.setImage(UIImage(named: "btnCheckEmpty"), for: .normal)
            }
        }
    }
   
    // MARK: - Initializer
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setView()
        contentView.addSubview(mainView)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    // MARK: - Actions
    
    // MARK: - Method
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setConstraint()
    }
    
    func setView(){
        self.contentView.backgroundColor = .background
    }
    
    func setConstraint(){contentView.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16 * SizeConstants.screenRatio)
            make.top.bottom.equalToSuperview().inset(8 * SizeConstants.screenRatio)
        }
        
        mainView.addSubviews([titleLabel, previewLabel, checkButton])
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16 * SizeConstants.screenRatio)
            make.top.equalToSuperview().inset(17 * SizeConstants.screenRatio)
        }
        
        previewLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.top.equalTo(titleLabel.snp.bottom).offset(18 * SizeConstants.screenRatio)
            make.bottom.equalToSuperview().inset(18 * SizeConstants.screenRatio)
        }
        
        checkButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16 * SizeConstants.screenRatio)
        }
        checkButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20 * SizeConstants.screenRatio)
        }
    }
}

