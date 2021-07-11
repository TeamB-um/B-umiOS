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
    
//    private let background

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
        $0.image = UIImage(named: "homeAreaTrashbin")
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
        $0.transform = CGAffineTransform(rotationAngle: -CGFloat(Double.pi / 180 * 45))
        $0.isHidden = true
    }
    
    private lazy var paper2Button = UIButton().then {
        $0.addTarget(self, action: #selector(didTapPaperButton(_:)), for: .touchUpInside)
        $0.backgroundColor = .paper2
        $0.tag = 2
        $0.transform = CGAffineTransform(rotationAngle: -CGFloat(Double.pi / 180 * 15))
        $0.isHidden = true
    }
    
    private lazy var paper3Button = UIButton().then {
        $0.addTarget(self, action: #selector(didTapPaperButton(_:)), for: .touchUpInside)
        $0.backgroundColor = .paper3
        $0.tag = 3
        $0.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 180 * 15))
        $0.isHidden = true
    }
    
    private lazy var paper4Button = UIButton().then {
        $0.addTarget(self, action: #selector(didTapPaperButton(_:)), for: .touchUpInside)
        $0.backgroundColor = .paper4
        $0.tag = 4
        $0.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 180 * 45))
        $0.isHidden = true
    }
    
    private let whiteShadowView = UIImageView().then {
        $0.image = UIImage(named: "bgElements")
        $0.isHidden = true
    }

    // MARK: - Properties
    
    let animator = UIViewPropertyAnimator(duration: 0.6, curve: .easeOut)
    var isSelectedTrashBin = false {
        didSet {
            if isSelectedTrashBin {
                guideLabel.text = "스트레스 양에 따라\n종이를 선택하세요"
                arrowImage.isHidden = true
                
                whiteShadowView.isHidden = false
                [paper1Button, paper2Button, paper3Button, paper4Button].forEach { button in
                    button.isHidden = false
                }
            } else {
                guideLabel.text = "휴지통을 클릭해\n스트레스를 비워보세요"
                arrowImage.isHidden = false
                
                whiteShadowView.isHidden = true
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
        configureInitAnimate()
    }
    
    // MARK: - Actions
    
    @objc
    func didTapTrashBinButton(_ sender: UIButton) {
        isSelectedTrashBin.toggle()
        
        if isSelectedTrashBin {
            configureAnimate()
            animator.startAnimation()
        } else {
            animator.stopAnimation(true)
            configureInitAnimate()
        }
    }
    
    @objc
    func didTapPaperButton(_ sender: UIButton) {
        if let style = WritingStyle(rawValue: sender.tag) {
            navigationController?.pushViewController(WritingViewController(style: style), animated: true)
        }
    }
    
    // MARK: - Methods
    
    func setConstraint() {
        view.addSubviews([whiteShadowView, dateLabel, guideLabel, arrowImage, trashBinButton, paper1Button, paper2Button, paper3Button, paper4Button])
        
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
            make.top.equalTo(guideLabel.snp.bottom).offset(37 * SizeConstants.screenRatio)
            make.width.height.equalTo(90 * SizeConstants.screenRatio)
        }
        
        trashBinButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(arrowImage.snp.bottom).offset(50)
        }
        
        let width = 55.7 / SizeConstants.screenWidth
        let height = 84.5 / width
        
        paper1Button.snp.makeConstraints { make in
            make.top.equalTo(guideLabel.snp.bottom).offset(90.39 * SizeConstants.screenRatio)
            make.leading.equalToSuperview().inset(33 * SizeConstants.screenRatio)
            make.width.equalTo(self.view).multipliedBy(width)
            make.height.equalTo(84.5).multipliedBy(height)
        }
        
        paper2Button.snp.makeConstraints { make in
            make.top.equalTo(guideLabel.snp.bottom).offset(47.77 * SizeConstants.screenRatio)
            make.leading.equalTo(paper1Button.snp.trailing).offset(33 * SizeConstants.screenRatio)
            make.width.equalTo(self.view).multipliedBy(width)
            make.height.equalTo(84.5).multipliedBy(height)
        }
        
        paper3Button.snp.makeConstraints { make in
            make.top.equalTo(paper2Button.snp.top)
            make.trailing.equalTo(paper4Button.snp.leading).offset(-24.81 * SizeConstants.screenRatio)
            make.width.equalTo(self.view).multipliedBy(width)
            make.height.equalTo(84.5).multipliedBy(height)
        }
        
        paper4Button.snp.makeConstraints { make in
            make.top.equalTo(paper1Button.snp.top)
            make.trailing.equalToSuperview().inset(33 * SizeConstants.screenRatio)
            make.width.equalTo(self.view).multipliedBy(width)
            make.height.equalTo(84.5).multipliedBy(height)
        }
        
        whiteShadowView.snp.makeConstraints { make in
            make.top.equalTo(guideLabel.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    func setView() {
        view.backgroundColor = UIColor.blue2Main
        
        navigationController?.isNavigationBarHidden = true
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    func configureInitAnimate() {
        whiteShadowView.alpha = 0
        paper1Button.alpha = 0
        paper2Button.alpha = 0
        paper3Button.alpha = 0
        paper4Button.alpha = 0

        whiteShadowView.transform = CGAffineTransform(translationX: 0, y: 100)
        paper1Button.transform = CGAffineTransform(translationX: 0, y: 100)
        paper2Button.transform = CGAffineTransform(translationX: 0, y: 100)
        paper3Button.transform = CGAffineTransform(translationX: 0, y: 100)
        paper4Button.transform = CGAffineTransform(translationX: 0, y: 100)
    }
    
    func configureAnimate() {
        animator.addAnimations {
            self.whiteShadowView.alpha = 1
            self.paper1Button.alpha = 1
            self.paper2Button.alpha = 1
            self.paper3Button.alpha = 1
            self.paper4Button.alpha = 1
            
            self.whiteShadowView.transform = .identity
            self.paper1Button.layer.transform = CATransform3DMakeRotation(-CGFloat(Double.pi / 180 * 45), 0, 0, 1)
            self.paper2Button.layer.transform = CATransform3DMakeRotation(-CGFloat(Double.pi / 180 * 15), 0, 0, 1)
            self.paper3Button.layer.transform = CATransform3DMakeRotation(CGFloat(Double.pi / 180 * 15), 0, 0, 1)
            self.paper4Button.layer.transform = CATransform3DMakeRotation(CGFloat(Double.pi / 180 * 45), 0, 0, 1)
        }
    }
    
    // MARK: - Protocols
}
