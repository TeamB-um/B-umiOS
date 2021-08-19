//
//  SeparatePresentPopUpViewController.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/08/16.
//

import UIKit

class SeparatePresentPopUpViewController: UIViewController {
    // MARK: - UIComponenets
    
    let presentImageView = UIImageView().then {
        $0.image = UIImage.imgReward
    }
    
    let explanationLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 18)
        $0.textColor = .white
        let attributedStr = NSMutableAttributedString(string: "미화원이 쓰레기를 비우다가\n뭔가 발견했어요!")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        paragraphStyle.alignment = .center
        attributedStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedStr.length))
        attributedStr.addAttribute(.foregroundColor, value: UIColor.pink2Main, range: ("미화원이 쓰레기를 비우다가\n뭔가 발견했어요!" as NSString).range(of: "뭔가 발견"))

        $0.attributedText = attributedStr
    }
    
    let backgroundButton = UIButton().then {
        $0.addTarget(self, action: #selector(didTapBackgroundButton(_:)), for: .touchUpInside)
    }
    
    // MARK: - Properties
    
    var indexPath_row : Int?
    var popupdelegate : popupDelegate?
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setConstraints()
    }
    
    // MARK: - Actions
    
    // MARK: - Methods
    
    func setView() {
        view.layer.backgroundColor = UIColor.black.withAlphaComponent(0.6).cgColor
    }
    
    func setConstraints() {
        view.addSubviews([presentImageView, explanationLabel,backgroundButton])
        
        backgroundButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        presentImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(302.0 * SizeConstants.screenHeight / 812.0)
        }
        
        explanationLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(presentImageView.snp.bottom).offset(21 * SizeConstants.screenHeight / 812.0)
        }
       
    }
    
    @objc private func didTapBackgroundButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {
            self.popupdelegate?.sendData(data: self.indexPath_row)
        })
    }
    
    // MARK: - Protocols
}
