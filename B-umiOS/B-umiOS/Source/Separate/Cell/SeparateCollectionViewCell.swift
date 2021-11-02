//
//  SeparateCollectionViewCell.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/06.
//

import UIKit

class SeparateCollectionViewCell: UICollectionViewCell {
    // MARK: - UIComponenets
    
    var separateImage = UIImageView().then {
        $0.image = UIImage.btnCheck
    }
    
    var separateName = UILabel().then {
        $0.text = ""
        $0.textColor = .blue3 //변경필요
        $0.textAlignment = .center
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 16)
    }
    
    // MARK: - Properites
    
    static let identifier = "SeparateCollectionViewCell"
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setView()
        setConstraints()
        isSelected = false
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
 
    override func prepareForReuse() {
        isSelected = false
    }
    
    // MARK: - Actions
    
    // MARK: - Methods
    
    func setView(){
        self.backgroundColor = .background
    }
    
    func setData(name : String, index: Int, count: Int){
        self.separateName.text = name
        
        if(name == "추가하기"){
            self.separateName.textColor = UIColor.textGray
            self.separateImage.image = UIImage.group174
        }
        else{
            self.separateName.textColor = SeparateStyle.color[index]
            let cnt = count <= 5 ? count : 5
            self.separateImage.image = UIImage(named: "\(SeparateStyle.image[index])\(cnt)")
        }
    }
    
    func setConstraints(){
        self.contentView.addSubviews([separateImage, separateName])

        let screenSize = UIScreen.main.bounds
        
        separateImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(separateImage.snp.width)
        }
        separateName.snp.makeConstraints { make in
            make.leading.trailing.equalTo(separateImage)
            make.top.equalTo(separateImage.snp.bottom).offset(8 * screenSize.width / 375)
            make.bottom.equalToSuperview()
        }
    }
}
