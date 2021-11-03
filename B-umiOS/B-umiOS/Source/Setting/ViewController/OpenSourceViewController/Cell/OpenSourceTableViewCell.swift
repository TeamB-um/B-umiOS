//
//  OpenSourceTableViewCell.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/11/02.
//

import UIKit

class OpenSourceTableViewCell: UITableViewCell {
    static let identifier = "OpenSourceTableViewCell"

    // MARK: - UIComponents

    let titleLabel = UILabel().then {
        $0.font = .nanumSquareFont(type: .extraBold, size: 18)
        $0.textColor = .paper4
    }
    
    let linkLabel = UILabel().then {
        $0.font = .nanumSquareFont(type: .regular, size: 15)
        $0.textColor = .blue4
        $0.lineBreakMode = .byTruncatingTail
    }
    
    let licenseLabel = UILabel().then {
        $0.font = .nanumSquareFont(type: .regular, size: 12)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byTruncatingTail
    }
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        titleLabel.text = ""
        linkLabel.text = ""
        licenseLabel.text = ""
    }
    
    // MARK: - Method
    
    func setCell(libarary: Library) {
        titleLabel.text = libarary.name
        linkLabel.text = libarary.link
        licenseLabel.text = libarary.license
    }
    
    func setConstraints() {
        contentView.addSubviews([titleLabel, linkLabel, licenseLabel])
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.trailing.equalToSuperview().inset(25)
        }
        
        linkLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(titleLabel)
        }
        
        licenseLabel.snp.makeConstraints { make in
            make.top.equalTo(linkLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(titleLabel)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}
