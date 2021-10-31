//
//  HomeViewController+Layout.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/12.
//

import UIKit

// MARK: - Layout (View) Method

extension HomeViewController {
    func setConstraints() {
        view.addSubviews([backgroundView, whiteShadowView, dateLabel, guideLabel, arrowImage, trashBinButton, paper1Button, paper2Button, paper3Button, paper4Button, lowLabel, highLabel])
        
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(SizeConstants.screenRatio * 13.0)
        }
        
        guideLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(dateLabel.snp.bottom).offset(40)
        }
        
        arrowImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(guideLabel.snp.bottom).offset(55 * SizeConstants.screenRatio)
            make.width.equalToSuperview().multipliedBy(90.0 / 375.0)
            make.height.equalTo(arrowImage.snp.width)
        }
        
        trashBinButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(arrowImage.snp.bottom).offset(59 * SizeConstants.screenRatio)
            make.width.equalToSuperview().multipliedBy(187.0 / 375.0)
            make.height.equalToSuperview().multipliedBy(0.312)
        }
        
        let width = 55.7 / SizeConstants.screenWidth
        let height = 84.5 / width
        
        paper1Button.snp.makeConstraints { make in
            make.top.equalTo(whiteShadowView.snp.top).offset(67.39 * SizeConstants.screenRatio)
            make.leading.equalToSuperview().inset(33 * SizeConstants.screenRatio)
            make.width.equalToSuperview().multipliedBy(width)
            make.height.equalTo(84.5).multipliedBy(height)
        }
        
        paper2Button.snp.makeConstraints { make in
            make.top.equalTo(whiteShadowView.snp.top).offset(24.77 * SizeConstants.screenRatio)
            make.leading.equalTo(paper1Button.snp.trailing).offset(24.81 * SizeConstants.screenRatio)
            make.width.equalToSuperview().multipliedBy(width)
            make.height.equalTo(84.5).multipliedBy(height)
        }
        
        paper3Button.snp.makeConstraints { make in
            make.top.equalTo(paper2Button.snp.top)
            make.trailing.equalTo(paper4Button.snp.leading).offset(-24.81 * SizeConstants.screenRatio)
            make.width.equalToSuperview().multipliedBy(width)
            make.height.equalTo(84.5).multipliedBy(height)
        }
        
        paper4Button.snp.makeConstraints { make in
            make.top.equalTo(paper1Button.snp.top)
            make.trailing.equalToSuperview().inset(33 * SizeConstants.screenRatio)
            make.width.equalToSuperview().multipliedBy(width)
            make.height.equalTo(84.5).multipliedBy(height)
        }
        
        whiteShadowView.snp.makeConstraints { make in
            make.top.equalTo(guideLabel.snp.bottom).offset(15)
            make.width.equalToSuperview()
            make.height.equalTo(whiteShadowView.snp.width).multipliedBy(264.0 / 375.0)
        }
        
        lowLabel.snp.makeConstraints { make in
            make.top.equalTo(whiteShadowView.snp.top).offset(189 * SizeConstants.screenRatio)
            make.leading.equalToSuperview().offset(16.0 * SizeConstants.screenRatio)
        }
        
        highLabel.snp.makeConstraints { make in
            make.top.equalTo(lowLabel.snp.top)
            make.trailing.equalToSuperview().offset(-16.0 * SizeConstants.screenRatio)
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
        arrowImage.alpha = 1

        whiteShadowView.transform = CGAffineTransform(translationX: 0, y: 100)
        paper1Button.transform = CGAffineTransform(translationX: 0, y: 100).rotated(by: CGFloat(Double.pi / 180 * 45))
        paper2Button.transform = CGAffineTransform(translationX: 0, y: 100).rotated(by: CGFloat(Double.pi / 180 * 15))
        paper3Button.transform = CGAffineTransform(translationX: 0, y: 100)
            .rotated(by: -CGFloat(Double.pi / 180 * 15))
        paper4Button.transform = CGAffineTransform(translationX: 0, y: 100).rotated(by: -CGFloat(Double.pi / 180 * 45))
    }
    
    func configureAnimate() {
        animator.addAnimations {
            self.whiteShadowView.alpha = 1
            self.paper1Button.alpha = 1
            self.paper2Button.alpha = 1
            self.paper3Button.alpha = 1
            self.paper4Button.alpha = 1
            self.arrowImage.alpha = 0
            
            self.whiteShadowView.transform = .identity
            self.paper1Button.layer.transform = CATransform3DMakeRotation(-CGFloat(Double.pi / 180 * 45), 0, 0, 1)
            self.paper2Button.layer.transform = CATransform3DMakeRotation(-CGFloat(Double.pi / 180 * 15), 0, 0, 1)
            self.paper3Button.layer.transform = CATransform3DMakeRotation(CGFloat(Double.pi / 180 * 15), 0, 0, 1)
            self.paper4Button.layer.transform = CATransform3DMakeRotation(CGFloat(Double.pi / 180 * 45), 0, 0, 1)
        }
    }
    
    func makeLabelTransition() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = .init(name: .easeInEaseOut)
        transition.type = .fade
        
        guideLabel.layer.add(transition, forKey: CATransitionType.push.rawValue)
        
        transition.type = .push
        transition.subtype = isSelectedTrashBin ? .fromTop : .fromBottom
        lowLabel.layer.add(transition, forKey: CATransitionType.push.rawValue)
        highLabel.layer.add(transition, forKey: CATransitionType.push.rawValue)
    }
    
    func reverseArrowAnimate() {
        UIView.animate(withDuration: 1.3, delay: 0, options: [.repeat, .autoreverse]) {
            self.arrowImage.transform = CGAffineTransform(translationX: 0, y: 40).scaledBy(x: 0.9, y: 0.9)
        } completion: { _ in
            self.arrowImage.transform = .identity
        }
    }
}
