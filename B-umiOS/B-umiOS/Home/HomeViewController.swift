//
//  HomeViewController.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/01.
//

import SnapKit
import Then
import UIKit

// TODO: - guide label 숨김 처리

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
    
    private lazy var paper1Button = UIButton().then {
        $0.addTarget(self, action: #selector(didTapPaperButton(_:)), for: .touchUpInside)
        $0.backgroundColor = .paper1
        $0.tag = 3
        $0.transform = CGAffineTransform(rotationAngle: -CGFloat(Double.pi / 4))
        $0.isHidden = true
    }
    
    private lazy var paper2Button = UIButton().then {
        $0.addTarget(self, action: #selector(didTapPaperButton(_:)), for: .touchUpInside)
        $0.backgroundColor = .paper2
        $0.tag = 2
        $0.transform = CGAffineTransform(rotationAngle: -CGFloat(Double.pi / 4))
        $0.isHidden = true
    }
    
    private lazy var paper3Button = UIButton().then {
        $0.addTarget(self, action: #selector(didTapPaperButton(_:)), for: .touchUpInside)
        $0.backgroundColor = .paper3
        $0.tag = 3
        $0.transform = CGAffineTransform(rotationAngle: -CGFloat(Double.pi / 4))
        $0.isHidden = true
    }
    
    private lazy var paper4Button = UIButton().then {
        $0.addTarget(self, action: #selector(didTapPaperButton(_:)), for: .touchUpInside)
        $0.backgroundColor = .paper4
        $0.tag = 4
        $0.transform = CGAffineTransform(rotationAngle: -CGFloat(Double.pi / 4))
        $0.isHidden = true
    }

    // MARK: - Properties
    
    var isSelectedTrashBin = false {
        didSet {
            if isSelectedTrashBin {
                guideLabel.text = "스트레스 양에 따라\n종이를 선택하세요"
                arrowImage.isHidden = true
                
                [paper1Button, paper2Button, paper3Button, paper4Button].forEach { button in
                    button.isHidden = false
                }
            } else {
                guideLabel.text = "휴지통을 클릭해\n스트레스를 비워보세요"
                arrowImage.isHidden = false
                
                [paper1Button, paper2Button, paper3Button, paper4Button].forEach { button in
                    button.isHidden = true
                }
            }
        }
    }
    
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
        isSelectedTrashBin.toggle()
    }
    
    @objc
    func didTapPaperButton(_ sender: UIButton) {
        if let style = WritingStyle(rawValue: sender.tag) {
            navigationController?.pushViewController(WritingViewController(style: style), animated: true)
        }
    }
    
    // MARK: - Methods
    
    func setConstraint() {
        view.addSubviews([dateLabel, guideLabel, arrowImage, trashBinButton, paper1Button, paper2Button, paper3Button, paper4Button])
        
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
        
        let width = 55.7 / UIScreen.main.bounds.width
        let height = 84.5 / width
        
        paper1Button.snp.makeConstraints { make in
            make.top.equalTo(guideLabel.snp.bottom).offset(90.39)
            make.leading.equalToSuperview().inset(33)
            make.width.equalTo(self.view).multipliedBy(width)
            make.height.equalTo(84.5).multipliedBy(height)
        }
        
        paper2Button.snp.makeConstraints { make in
            make.top.equalTo(guideLabel.snp.bottom).offset(90.39)
            make.leading.equalToSuperview().inset(33)
            make.width.equalTo(self.view).multipliedBy(width)
            make.height.equalTo(84.5).multipliedBy(height)
        }
        
        paper3Button.snp.makeConstraints { make in
            make.top.equalTo(guideLabel.snp.bottom).offset(90.39)
            make.leading.equalToSuperview().inset(33)
            make.width.equalTo(self.view).multipliedBy(width)
            make.height.equalTo(84.5).multipliedBy(height)
        }
        
        paper4Button.snp.makeConstraints { make in
            make.top.equalTo(guideLabel.snp.bottom).offset(90.39)
            make.leading.equalToSuperview().inset(33)
            make.width.equalTo(self.view).multipliedBy(width)
            make.height.equalTo(84.5).multipliedBy(height)
        }
    }
    
    func setView() {
        view.backgroundColor = UIColor.blue2Main
        
        navigationController?.isNavigationBarHidden = true
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    // MARK: - Protocols
}
