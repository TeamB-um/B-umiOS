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
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 14)
        $0.textColor = .blue2Main
    }
    
    var remainingDayLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 14)
        $0.textColor = .pink2Main
        $0.textAlignment = .right
    }
    
    var headerLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 18)
        $0.textColor = .header
    }
    
    var previewLabel = UILabel().then {
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
    
    func setTrashBinData(data:[TrashCan], index: Int){
        categoryLabel.text = data[index].category.name
        remainingDayLabel.text = "D-\(data[index].dDay)"
        headerLabel.text = data[index].title
        previewLabel.text = data[index].text
    }
    
    func setView(){
        self.contentView.backgroundColor = .background
    }
    
    func setConstraint(){
        contentView.addSubview(mainView)
        mainView.addSubviews([categoryLabel, remainingDayLabel, headerLabel, previewLabel])

        mainView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16 * SizeConstants.screenRatio)
            make.top.bottom.equalToSuperview().inset(8 * SizeConstants.screenRatio)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16 * SizeConstants.screenRatio)
            make.top.equalToSuperview().inset(12 * SizeConstants.screenRatio)
        }
        
        remainingDayLabel.snp.makeConstraints { make in
            make.centerY.equalTo(categoryLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(16 * SizeConstants.screenRatio)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.leading.equalTo(categoryLabel.snp.leading)
            make.trailing.equalTo(remainingDayLabel.snp.trailing)
            make.top.equalTo(categoryLabel.snp.bottom).offset(12 * SizeConstants.screenRatio)
        }
        
        previewLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16 * SizeConstants.screenRatio)
            make.top.equalTo(headerLabel.snp.bottom).offset(14 * SizeConstants.screenRatio)
            make.bottom.equalToSuperview().inset(12 * SizeConstants.screenRatio)
        }
    }
}
