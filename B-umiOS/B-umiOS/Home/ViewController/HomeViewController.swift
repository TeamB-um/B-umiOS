//
//  HomeViewController.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/01.
//

import SnapKit
import Then
import UIKit

class HomeViewController: UIViewController {
    // MARK: - UIComponenets

    private let dateLabel = UILabel().then {
        $0.text = Date().dateToString(date: Date())
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
        $0.textColor = .white
    }
    
    private let guideLabel = UILabel().then {
        $0.text = "휴지통을 클릭해\n스트레스를 비워보세요"
        $0.lineSpacing(spacing: 13)
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 26)
        $0.textColor = UIColor.white
    }
    
    private let arrowImage = UIImageView().then {
        $0.image = UIImage(named: "bgElements")
    }
    
    private lazy var trashBinButton = UIButton().then {
        $0.addTarget(self, action: #selector(didTapTrashBinButton(_:)), for: .touchUpInside)
        $0.backgroundColor = .green3
        $0.setTitle("쓰레기통", for: .normal)
        $0.tintColor = .white
    }
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setConstraint()
    }
    
    // MARK: - Actions
    
    @objc
    func didTapTrashBinButton(_ sender: UIButton) {
        navigationController?.pushViewController(WritingViewController(), animated: true)
    }
    
    // MARK: - Methods
    
    func setConstraint() {
        view.addSubviews([dateLabel, guideLabel, arrowImage, trashBinButton])
        
        dateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(13)
        }
        
        guideLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(dateLabel.snp.bottom).offset(40)
        }
        
        arrowImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(guideLabel.snp.bottom).offset(44)
            make.width.height.equalTo(75 * UIScreen.main.bounds.width / 375)
        }
        
        trashBinButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(arrowImage.snp.bottom).offset(50)
        }
    }
    
    func setView() {
        view.backgroundColor = UIColor.blue2Main
        
        navigationController?.isNavigationBarHidden = true
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    // MARK: - Protocols
}
