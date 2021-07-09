//
//  MyTrashBinTableViewCell.swift
//  B-umiOS
//
//  Created by kong on 2021/07/09.
//

import UIKit

class MyTrashBinTableViewCell: UITableViewCell {
    // MARK: - UIComponenets
  
    var mainView = UIView().then {
        $0.backgroundColor = .white
        $0.cornerRound(radius: 10)
        $0.setShadow(radius: 10, offset: CGSize(width: 0, height: 4), opacity: 0.25, color: .paper2)
    }
    
    var categoryLabel = UILabel().then {
        $0.text = "거지챌린지"
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 14)
        $0.textColor = .blue2Main
    }
    
    var remainingDayLabel = UILabel().then {
        $0.text = "D-365"
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 14)
        $0.textColor = .pink2Main
        $0.textAlignment = .right
    }
    
    var headerLabel = UILabel().then {
        $0.text = "거지챌린지"
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 18)
        $0.textColor = .header
    }
    
    var previewLabel = UILabel().then {
        $0.text = "버들가쥣쓰는 야카나..다른 재목을 묵는 버들가짓스다.버들가쥣쓰는 야카나..다른 재목을 묵는 버들가짓스다.버들가쥣쓰는 야카나..다른 재목을 묵는 버들가짓스다."
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 14)
        $0.textColor = .textGray
        $0.lineBreakMode = .byTruncatingTail
    }
    // MARK: - Properites
    
    static let identifier = "MyTrashBinTableViewCell"
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
        
        mainView.addSubviews([categoryLabel, remainingDayLabel, headerLabel, previewLabel])
        
        categoryLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16 * SizeConstants.ScreenRatio)
            make.top.equalToSuperview().inset(12 * SizeConstants.ScreenRatio)
        }
        
        remainingDayLabel.snp.makeConstraints { make in
            make.centerY.equalTo(categoryLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(16 * SizeConstants.ScreenRatio)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.leading.equalTo(categoryLabel.snp.leading)
            make.trailing.equalTo(remainingDayLabel.snp.trailing)
            make.top.equalTo(categoryLabel.snp.bottom)
        }
        
        previewLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16 * SizeConstants.ScreenRatio)
            make.top.equalTo(headerLabel.snp.bottom)
            make.bottom.equalToSuperview().inset(12 * SizeConstants.ScreenRatio)
        }
    }
}

