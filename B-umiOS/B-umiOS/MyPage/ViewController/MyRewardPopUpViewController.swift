//
//  MyRewardPopUpViewController.swift
//  B-umiOS
//
//  Created by kong on 2021/07/11.
//

import UIKit

struct DummyReward {
    var trashBinIndex: Int
    var date: Date
    var titleReward: String
    var authorName: String
    var subReward: String
}

class MyRewardPopUpViewController: UIViewController {
    // MARK: - UIComponenets
    
    private let popUpView = UIView().then {
        $0.cornerRound(radius: 10)
    }
    
    private lazy var backgroundImageView = UIImageView().then {
        $0.image = UIImage(named: "\(reward.trashBinIndex)")
    }
    
    private lazy var closeButton = UIButton(primaryAction: UIAction(handler: { _ in
        self.dismiss(animated: true, completion: nil)
    })).then {
        $0.setImage(UIImage(named: "btnCloseBlack"), for: .normal)
        $0.tintColor = .white
    }
    
    private lazy var rewardLabel =  UILabel().then {
        $0.text = "리워드"
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
        $0.textColor = .white
    }
    
    private lazy var dateLabel = UILabel().then {
        $0.text = Date().dateToString(format: "yyyy년 MM월 dd일 (E)", date: self.reward.date)
        $0.font = .systemFont(ofSize: 15, weight: .regular)
        $0.textColor = .white
    }
    
    private lazy var titleRewardLabel = UILabel().then {
        $0.text = self.reward.titleReward
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
        $0.textColor = .white
        $0.numberOfLines = 0
        $0.lineSpacing(spacing: 10)
        $0.textAlignment = .center
    }
    
    private lazy var authorLabel = UILabel().then {
        $0.text = "-\(self.reward.authorName)-"
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
        $0.textColor = .white
    }
    
    private lazy var subRewardLabel = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 14)
        $0.numberOfLines = 0
        $0.text = self.reward.subReward
    }
    
    private let scrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
    }
    
    private let contentView = UIView()
    
    // MARK: - Properties
    
    private let reward: DummyReward
    
    // MARK: - Initializer
    
    init(reward: DummyReward) {
        self.reward = reward
        super.init(nibName: nil, bundle: nil)
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
    
    func setConstraints() {
        view.addSubviews([popUpView])
        popUpView.addSubviews([backgroundImageView, rewardLabel, closeButton, dateLabel, titleRewardLabel, authorLabel, subRewardLabel])
        
        popUpView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(343 * SizeConstants.screenRatio)
            make.height.equalTo(593 * SizeConstants.screenRatio)
        }
        
        backgroundImageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        rewardLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(23 * SizeConstants.screenRatio)
            make.centerX.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(4 * SizeConstants.screenRatio)
            make.trailing.equalToSuperview().inset(4 * SizeConstants.screenRatio)
            make.width.height.equalTo(48 * SizeConstants.screenRatio)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(rewardLabel.snp.bottom).offset(10 * SizeConstants.screenRatio)
            make.centerX.equalToSuperview()
        }
        
        titleRewardLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(191 * SizeConstants.screenRatio)
            make.bottom.equalToSuperview().inset(317 * SizeConstants.screenRatio)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(titleRewardLabel.snp.bottom).offset(35)
            make.centerX.equalToSuperview()
        }
        
        subRewardLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(authorLabel.snp.bottom).offset(70 * SizeConstants.screenRatio)
            make.bottom.equalToSuperview().inset(111 * SizeConstants.screenRatio)
        }
        
    }
    
    func setView() {
        view.layer.backgroundColor = UIColor.black.withAlphaComponent(0.5).cgColor
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view != popUpView {
            dismiss(animated: true, completion: nil)
        }
    }

    // MARK: - Protocols
}
