//
//  GraphComponentView.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/09.
//

import Foundation
import UIKit

class GraphComponentView : UIView{
    // MARK: - UIComponenets
    var circle = UIImageView().then {
        $0.image = UIImage.init(systemName: "circle.fill")
    }
    
    var categoryName = UILabel().then {
        $0.text = "인간관계"
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 14)
    }
    
    var percent = UILabel().then {
        $0.text = "35%"
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 14)
    }
    // MARK: - Initializer
    
    init(){
        super.init(frame: .init(x: 0, y: 0, width: 300 * SizeConstants.screenWidth, height: 46 * SizeConstants.screenRatio))
        setData()
        setView()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    
    func setData(){
        //self.categoryName.text =
        //self.percent.text =
    }
    
    func setView(){
        //self.circle.tintColor
        //self.categoryName.textColor
        self.backgroundColor = .gray
        //self.cornerRound(radius: 10)
    
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
            make.trailing.equalToSuperview().inset(10).priority(.high)
            //make.leading.equalTo(categoryName.snp.trailing).offset(10)
        }
        
        self.snp.makeConstraints { make in
            make.width.equalTo(146)
            make.height.equalTo(46)
        }
    }
    // MARK: - Extension
}
