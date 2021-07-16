//
//  GraphView.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/09.
//

import Foundation
import MultiProgressView
import UIKit

class GraphView: UIView {
    // MARK: - UIComponenets
        
    var emptyImage = UIImageView().then {
        $0.image = UIImage(named: "group192")
        $0.isHidden = true
    }
    
    var emptyLabel = UILabel().then {
        $0.textColor = .textGray
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 14)
        $0.isHidden = true
    }
    
    lazy var titleLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 18)
        $0.textColor = .header
    }
    
    lazy var subLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 13)
        $0.textColor = .paper3
    }
    
    let progressBackGroundView = UIView().then {
        $0.backgroundColor = .white
    }
        
    lazy var progressView = MultiProgressView().then {
        $0.cornerRadius = 18
        $0.lineCap = .round
        $0.trackInset = 5
        $0.trackBackgroundColor = .disable
        $0.trackBorderColor = .blue
    }
    
    let verticalStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 11 * SizeConstants.screenRatio
        $0.backgroundColor = .white
    }
    
    // MARK: - Properties
    
    var graphData: [GraphComponent] = []
    var componentsView: [GraphComponentView] = []
    
    // MARK: - Initializer
    
    init(title: String, sub: String) {
        super.init(frame: .init(x: 0, y: 0, width: SizeConstants.screenWidth, height: 200))
        self.backgroundColor = .white
        
        self.titleLabel.text = "\(title) 그래프"
        self.subLabel.text =  "\(sub) 스트레스 비율입니다"

        setConstraint()
        progressView.dataSource = self
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method
    
    func setConstraint() {
        addSubviews([titleLabel, subLabel, progressBackGroundView, verticalStackView, emptyImage, emptyLabel])
        
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
            make.leading.trailing.equalToSuperview().inset(15 * SizeConstants.screenRatio)
            make.top.equalTo(subLabel.snp.bottom).offset(19 * SizeConstants.screenRatio)
            make.height.equalTo(32 * SizeConstants.screenRatio)
        }
        
        progressView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.top.equalTo(progressBackGroundView.snp.bottom).offset(31 * SizeConstants.screenRatio)
            make.leading.trailing.equalToSuperview().inset(20 * SizeConstants.screenRatio)
            make.bottom.equalToSuperview()
        }
        
        emptyImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(subLabel.snp.bottom).offset(32 * SizeConstants.screenRatio)
            make.width.equalTo(120 * SizeConstants.screenRatio)
            make.height.equalTo(135 * SizeConstants.screenRatio)
        }
        
        emptyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emptyImage.snp.bottom)
        }
    }
    
    var p = 100
    func setStackView() {
        
        for i in 0 ..< graphData.count{
            if(i == 3 && graphData.count != 4){
                componentsView.append(GraphComponentView(name: "기타", percent: "\(p)%", color: 8))
                break
            }
            componentsView.append(GraphComponentView(name: graphData[i].name, percent: "\(graphData[i].percent)%", color: graphData[i].index))
            p -= graphData[i].percent
        }
   
        while(componentsView.count < 4){
            componentsView.append(GraphComponentView(name: nil, percent: nil, color: nil))
        }
        
        for i in 0 ... 1 {
          
            let horizontalStackView = UIStackView(arrangedSubviews: [componentsView[2*i], componentsView[2*i+1]]).then {
                $0.alignment = .fill
                $0.spacing = 11 * SizeConstants.screenRatio
                $0.axis = .horizontal
                $0.distribution = .fillEqually
            }
            
            verticalStackView.addArrangedSubview(horizontalStackView)
        }
    }
    
    func setGraph(data: [GraphComponent]){
        graphData = data
        self.progressView.reloadData()
        DispatchQueue.main.async {
            for (index,item) in data.enumerated(){
                let percent = Float(item.percent)/100.0
                self.progressView.setProgress(section: index, to: percent)
            }
            self.setStackView()
        }
    }
}

// MARK: - Extension

extension GraphView: MultiProgressViewDataSource {
    func numberOfSections(in progressView: MultiProgressView) -> Int {
        graphData.count
    }
    
    func progressView(_ progressView: MultiProgressView, viewForSection section: Int) -> ProgressViewSection {
        let bar = ProgressViewSection()
        bar.backgroundColor = SeparateStyle.color[graphData[section].index]
        return bar
    }
}
