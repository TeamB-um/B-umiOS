//
//  PresentViewController.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/09/09.
//

import Lottie
import UIKit

protocol PresentDelegate: AnyObject {
    func dismissPopUp()
}

class PresentViewController: UIViewController {
    // MARK: - UIComponenets
   
    let titleLabel = UILabel().then {
        $0.font = .nanumSquareFont(type: .extraBold, size: 20)
        $0.textColor = .header
        $0.text = "미화원의 선물"
    }

    let animationView = AnimationView().then {
        $0.animation = Animation.named("present_ios")
        $0.loopMode = .playOnce
    }
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
        
        animationView.play { _ in
            let popUpVC = TodayPresentPopUpViewController(content: "머 어쩌라능")
            popUpVC.modalTransitionStyle = .crossDissolve
            popUpVC.modalPresentationStyle = .overCurrentContext
            popUpVC.delegate = self
            
            self.tabBarController?.present(popUpVC, animated: true, completion: nil)
        }
    }
    
    // MARK: - Actions
    
    // MARK: - Methods
    
    func setConstraints() {
        view.addSubviews([animationView, titleLabel])
        animationView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(57)
        }
    }
}

// MARK: - Protocols

extension PresentViewController: PresentDelegate {
    func dismissPopUp() {
        navigationController?.popViewController(animated: true)
    }
}
