//
//  GraphView.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/09.
//

import Foundation
import UIKit
import MultiProgressView

class GraphView : UIView {
    // MARK: - UIComponenets
        
    lazy var titleLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 18)
        $0.textColor = .header
        $0.text = "월간 그래프"
    }
    
    lazy var subLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 13)
        $0.textColor = .paper3
        $0.text = "한 달 내 카테고리별 스트레스 비율입니다"
    }
    
    let progressBackGroundView = UIView().then {
        $0.backgroundColor = .systemGray6
    }
        
    lazy var progressView = MultiProgressView().then {
        $0.cornerRadius = 18
        $0.lineCap = .round
        $0.trackInset = 5
        $0.trackBackgroundColor = .lightGray
        $0.trackBorderColor = .blue
    }
    
    let horizonStackView = UIStackView().then {
        $0.axis = .vertical
    }
    let verticalStackView = UIStackView().then {
        $0.axis = .vertical
    }
    
    let component = GraphComponentView()
    
    // MARK: - Initializer
    
    init(){
        super.init(frame: .init(x: 0, y: 0, width: SizeConstants.screenWidth, height: 200))
        setConstraint()
        progressView.dataSource = self
        DispatchQueue.main.async {
            self.progressView.setProgress(section: 0, to: 0.4)
            self.progressView.setProgress(section: 1, to: 0.3)
            self.progressView.setProgress(section: 2, to: 0.2)
            self.progressView.setProgress(section: 3, to: 0.1)
        }
    }
    
    required init(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
     }
    
    // MARK: - Method
    
    func setConstraint(){
        self.addSubviews([titleLabel, subLabel, progressBackGroundView, component, horizonStackView, verticalStackView])
        progressBackGroundView.addSubview(progressView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(20 * SizeConstants.screenRatio)
        }
        
        subLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.top.equalTo(titleLabel.snp.bottom).offset(10 * SizeConstants.screenRatio)
        }
        
        progressBackGroundView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20 * SizeConstants.screenRatio)
            make.top.equalTo(subLabel.snp.bottom).offset(24 * SizeConstants.screenRatio)
            make.height.equalTo(36 * SizeConstants.screenRatio)
        }
        
        progressView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        
        component.snp.makeConstraints { make in
            make.top.equalTo(progressBackGroundView.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(20 * SizeConstants.screenRatio)
        }
    }
}

// MARK: - Extension
extension GraphView : MultiProgressViewDataSource{
    func numberOfSections(in progressView: MultiProgressView) -> Int {
        return 4
    }
    
    func progressView(_ progressView: MultiProgressView, viewForSection section: Int) -> ProgressViewSection {
        let bar = ProgressViewSection()
        let colors : [UIColor] = [ .red, .blue, .green, .systemPink]
        bar.backgroundColor = colors[section]
        return bar
    }
}
