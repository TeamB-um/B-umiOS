//
//  GraphComponentView.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/09.
//

import Foundation
import UIKit

class GraphComponentView: UIView {
    // MARK: - UIComponenets
    
    var circle = UIImageView().then {
        $0.image = UIImage.init(systemName: "circle.fill")
    }
    
    var categoryName = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 14)
    }
    
    var percent = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 15)
        $0.textColor = .paper4
    }
    
    // MARK: - Initializer
    
    init(name: String, percent: String, color: Int?){
        self.categoryName.text = name
        self.categoryName.textColor = SeparateStyle.color[color ?? 8]
        self.percent.text = percent
        self.circle.tintColor = SeparateStyle.color[color ?? 8]
        
        super.init(frame: .init(x: 0, y: 0, width: 300 * SizeConstants.screenWidth, height: 46 * SizeConstants.screenRatio))
        setView()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method

    func setView(){
        self.backgroundColor = .background
        self.cornerRound(radius: 10)
    
    }
    
    func setConstraint(){
        self.addSubviews([circle, categoryName, percent])

        circle.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10 * SizeConstants.screenRatio)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(10 *  SizeConstants.screenRatio)
        }

        categoryName.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(circle.snp.trailing).offset(4 * SizeConstants.screenRatio)
            
        }

        percent.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
        }
        
        self.snp.makeConstraints { make in
            make.height.equalTo(46 * SizeConstants.screenRatio)
        }
    }
    
    // MARK: - Extension
}
