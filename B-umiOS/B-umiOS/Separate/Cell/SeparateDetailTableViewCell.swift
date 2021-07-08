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
    
    var checkButton = UIButton().then {
        $0.setImage(UIImage(named: "btnCheckEmpty"), for: .normal)
    }
    
    // MARK: - Properites
    
    static let identifier = "SeparateDetailTableViewCell"
    // MARK: - Initializer
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        setView()
        setConstraint()
    }
    
    // MARK: - Method
    
    func setView(){
        self.contentView.backgroundColor = .background
    }
    
    func setConstraint(){
        contentView.addSubview(mainView)
        
        mainView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16 * SizeConstants.ScreenRatio)
            make.top.bottom.equalToSuperview().inset(8 * SizeConstants.ScreenRatio)
        }
        
        mainView.addSubviews([titleLabel, previewLabel, checkButton])
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16 * SizeConstants.ScreenRatio)
            make.top.equalToSuperview().inset(17 * SizeConstants.ScreenRatio)
        }
        
        previewLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.top.equalTo(titleLabel.snp.bottom).offset(18 * SizeConstants.ScreenRatio)
            make.bottom.equalToSuperview().inset(18 * SizeConstants.ScreenRatio)
        }
        
        checkButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16 * SizeConstants.ScreenRatio)
        }
        checkButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20 * SizeConstants.ScreenRatio)
        }
    }
}

