//
//  MyRewardPopUpViewController.swift
//  B-umiOS
//
//  Created by kong on 2021/07/11.
//

import UIKit

class MyRewardPopUpViewController: UIViewController {
    // MARK: - UIComponenets
    
    let popUpView = UIView().then {
        $0.cornerRound(radius: 10)
    }
    
    lazy var backgroundImageView = UIImageView()
    
    lazy var closeButton = UIButton(primaryAction: UIAction(handler: { _ in
        self.dismiss(animated: true, completion: nil)
    })).then {
        $0.setImage(UIImage.btnCloseBlack, for: .normal)
        $0.tintColor = .white
    }
    
    lazy var rewardLabel =  UILabel().then {
        $0.text = "리워드"
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
        $0.textColor = .white
    }
    
    lazy var dateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15, weight: .regular)
        $0.textColor = .white
    }
    
    lazy var titleLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
        $0.textColor = .white
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    
    lazy var authorLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
        $0.textColor = .white
    }
    
    lazy var subRewardLabel = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 14)
        $0.numberOfLines = 0
    }
    
    var logoImage = UIImageView().then {
        $0.image = UIImage.group163
    }
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    init(reward: Reward) {
        super.init(nibName: nil, bundle: nil)
        setMyRewardData(reward: reward)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setConstraints()
    }

    // MARK: - Actions
    
    // MARK: - Methods
    
    func setView() {
        view.layer.backgroundColor = UIColor.black.withAlphaComponent(0.5).cgColor
    }
    
    func setMyRewardData(reward: Reward) {
        let writtenDate = Date().ISOStringToDate(date: reward.createdDate ?? "")
        let date = Date().ISODateToString(format: "yyyy.MM.dd(E)", date: writtenDate)
        self.dateLabel.text = date
        
        titleLabel.text = reward.sentence
        titleLabel.lineSpacing(spacing: 10)
        titleLabel.textAlignment = .center
        
        subRewardLabel.text = reward.context
        subRewardLabel.lineSpacing(spacing: 7)
        subRewardLabel.textAlignment = .center
        
        authorLabel.text = reward.author
        backgroundImageView.image = UIImage(named: "\(reward.index)")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view != popUpView {
            dismiss(animated: true, completion: nil)
        }
    }

    // MARK: - Protocols
}
