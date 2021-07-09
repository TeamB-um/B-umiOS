//
//  SeparateGraphViewController.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/08.
//

import UIKit

class SeparateGraphViewController: UIViewController {
    // MARK: - UIComponenets
    
    private let popupView = UIView().then {
        $0.cornerRound(radius: 10)
        $0.backgroundColor = .white
    }
    
    private  let backgroundButton = UIButton().then {
        $0.addTarget(self, action: #selector(didTapBackgroundButton(_:)), for: .touchUpInside)
    }
    
    private lazy var headerLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
        $0.textColor = .header
        $0.text = "그래프"
    }
        
    private lazy var monthLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 18)
        $0.textColor = .header
        $0.text = "월간 그래프"
    }
    
    private lazy var subLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 13)
        $0.textColor = .paper3
        $0.text = "한 달 내 카테고리별 스트레스 비율입니다"
    }
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    static let identifier = "SeparateGraphViewController"
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setConstraint()
    }
    
    // MARK: - Actions
    
    @objc  private func didTapBackgroundButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    // MARK: - Methods
    
    func setView(){
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    }
    
    func setConstraint(){
        self.view.addSubviews([backgroundButton,popupView])
        popupView.addSubviews([headerLabel, monthLabel, subLabel])
        
        popupView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(80 * SizeConstants.screenRatio)
            make.leading.trailing.equalToSuperview().inset(16 * SizeConstants.screenRatio)
        }
        
        backgroundButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        headerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(19 * SizeConstants.screenRatio)
        }
        
        monthLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(90 * SizeConstants.screenRatio)
            make.leading.equalToSuperview().offset(20 * SizeConstants.screenRatio)
        }
        
        subLabel.snp.makeConstraints { make in
            make.leading.equalTo(monthLabel.snp.leading)
            make.top.equalTo(monthLabel.snp.bottom).offset(10 * SizeConstants.screenRatio)
        }
    }
}
