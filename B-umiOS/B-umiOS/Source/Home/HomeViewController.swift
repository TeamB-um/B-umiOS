//
//  HomeViewController.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/01.
//

import Lottie
import SnapKit
import Then
import UIKit

// TODO: - guide label 숨김 처리

class HomeViewController: UIViewController {
    // MARK: - UIComponenets
    
    let backgroundView = AnimationView().then {
        $0.animation = Animation.named("home_ios")
        $0.loopMode = .playOnce
    }

    let dateLabel = UILabel().then {
        $0.text = Date().dateToString(date: Date())
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
        $0.adjustsFontForContentSizeCategory = true
        $0.textColor = .white
    }
    
    let guideLabel = UILabel().then {
        $0.text = "휴지통을 클릭해\n스트레스를 비워보세요"
        $0.lineSpacing(spacing: 13)
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 26)
        $0.adjustsFontForContentSizeCategory = true
        $0.textColor = UIColor.white
    }
    
    let arrowImage = UIImageView().then {
        $0.image = UIImage.homeAreaTrashbin
    }
    
    lazy var trashBinButton = UIButton().then {
        $0.addTarget(self, action: #selector(didTapTrashBinButton(_:)), for: .touchUpInside)
        $0.backgroundColor = .clear
    }
    
    lazy var paper1Button = UIButton().then {
        $0.addTarget(self, action: #selector(didTapPaperButton(_:)), for: .touchUpInside)
        $0.backgroundColor = .paper1
        $0.tag = 1
        $0.transform = CGAffineTransform(rotationAngle: -CGFloat(Double.pi / 180 * 45))
        $0.isHidden = true
    }
    
    lazy var paper2Button = UIButton().then {
        $0.addTarget(self, action: #selector(didTapPaperButton(_:)), for: .touchUpInside)
        $0.backgroundColor = .paper2
        $0.tag = 2
        $0.transform = CGAffineTransform(rotationAngle: -CGFloat(Double.pi / 180 * 15))
        $0.isHidden = true
    }
    
    lazy var paper3Button = UIButton().then {
        $0.addTarget(self, action: #selector(didTapPaperButton(_:)), for: .touchUpInside)
        $0.backgroundColor = .paper3
        $0.tag = 3
        $0.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 180 * 15))
        $0.isHidden = true
    }
    
    lazy var paper4Button = UIButton().then {
        $0.addTarget(self, action: #selector(didTapPaperButton(_:)), for: .touchUpInside)
        $0.backgroundColor = .paper4
        $0.tag = 4
        $0.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 180 * 45))
        $0.isHidden = true
    }
    
    let whiteShadowView = UIImageView().then {
        $0.image = UIImage.bgElementsStroke
        $0.isHidden = true
    }
    
    let lowLabel = UILabel().then {
        $0.font = .nanumSquareFont(type: .extraBold, size: 20)
        $0.text = "적음"
        $0.textColor = .paper4
        $0.isHidden = true
    }
    
    let highLabel = UILabel().then {
        $0.font = .nanumSquareFont(type: .extraBold, size: 20)
        $0.text = "많음"
        $0.textColor = .paper4
        $0.isHidden = true
    }

    // MARK: - Properties
    
    let animator = UIViewPropertyAnimator(duration: 0.6, curve: .easeOut)
    var isSelectedTrashBin = false {
        didSet {
            if isSelectedTrashBin {
                guideLabel.text = "스트레스 양에 따라\n종이를 선택하세요"
                arrowImage.isHidden = true
                lowLabel.isHidden = false
                highLabel.isHidden = false
                
                whiteShadowView.isHidden = false
                [paper1Button, paper2Button, paper3Button, paper4Button].forEach { button in
                    button.isHidden = false
                }
            } else {
                guideLabel.text = "휴지통을 클릭해\n스트레스를 비워보세요"
                lowLabel.isHidden = true
                highLabel.isHidden = true
                
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
        setConstraints()
        configureInitAnimate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reverseArrowAnimate()
    }
    
    // MARK: - Actions
    
    @objc
    func didTapTrashBinButton(_ sender: UIButton) {
        isSelectedTrashBin.toggle()
        makeLabelTransition()
        
        if isSelectedTrashBin {
            configureAnimate()
            animator.startAnimation()
            
            backgroundView.play()
        } else {
            animator.stopAnimation(true)
            configureInitAnimate()
            
            backgroundView.play(fromProgress: backgroundView.currentProgress, toProgress: 0, loopMode: .playOnce) { _ in
                self.arrowImage.isHidden = false
            }
        }
    }
    
    @objc
    func didTapPaperButton(_ sender: UIButton) {
        if let style = WritingStyle(rawValue: sender.tag) {
            navigationController?.pushViewController(WritingViewController(style: style), animated: true)
        }
    }
    
    // MARK: - Methods
    
    // MARK: - Protocols
}
