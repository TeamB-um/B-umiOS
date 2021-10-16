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
        $0.textColor = .white
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
        
        setView()
        setConstraints()
        animationView.play { _ in
            self.fetchPresentData()
        }
    }
    
    // MARK: - Actions
    
    // MARK: - Methods
    
    func setView() {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
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
    
    func fetchPresentData() {
        PresentService.shared.fetchPresentData { response in
            guard let result = response as? NetworkResult<Any> else { return }
               
            switch result {
            case .success(let data):
                guard let presentResponse = data as? GeneralResponse<PresentResponse> else { return }
                   
                if let present = presentResponse.data?.present.sentence {
                    let popUpVC = TodayPresentPopUpViewController(content: present)
                    popUpVC.modalTransitionStyle = .crossDissolve
                    popUpVC.modalPresentationStyle = .overCurrentContext
                    popUpVC.delegate = self
                    
                    self.tabBarController?.present(popUpVC, animated: true, completion: nil)
                }
            default:
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}

// MARK: - Protocols

extension PresentViewController: PresentDelegate {
    func dismissPopUp() {
        navigationController?.popViewController(animated: true)
    }
}
