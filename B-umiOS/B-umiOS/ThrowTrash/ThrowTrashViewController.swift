//
//  ThrowTrashViewController.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/08.
//

import UIKit

enum TrashType: String {
    case trash = "삭제 휴지통"
    case separate = "분리수거함"
}

class ThrowTrashViewController: UIViewController {
    // MARK: - UIComponenets

    private let navigationView = UIView().then {
        $0.backgroundColor = .white
    }
    
    lazy var navigationLabel = UILabel().then {
        $0.text = self.trashType.rawValue
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
        $0.textColor = UIColor.header
    }
    
    lazy var backButton = UIButton(type: .custom, primaryAction: UIAction(handler: { _ in
        self.navigationController?.popViewController(animated: true)
    })).then {
        $0.setImage(UIImage(named: "btnBack"), for: .normal)
    }
    
    let explanationView = UIView().then {
        $0.backgroundColor = .white
        $0.cornerRound(radius: 10)
        $0.setShadow(radius: 13, offset: CGSize(width: 1, height: 4), opacity: 0.1, color: UIColor(red: 45 / 255, green: 45 / 255, blue: 45.255, alpha: 1))
    }
    
    let explanationImage = UIImageView().then {
        $0.image = UIImage(systemName: "book.fill")
    }
    
    lazy var explanationLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 14)
        $0.textColor = .iconGray
        let attributedStr = NSMutableAttributedString(string: explainString)

        attributedStr.addAttribute(.foregroundColor, value: UIColor.blue3, range: (explainString as NSString).range(of: self.trashType.rawValue))

        $0.attributedText = attributedStr
    }
    
    private let guideLabel = UILabel().then {
        $0.text = "쓰레기통으로 넣어보세요!"
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
        $0.textColor = .textGray
    }
    
    let trash = UIImageView().then {
        $0.image = UIImage(systemName: "paperplane.fill")
        $0.backgroundColor = .orange
    }
    
    let trashBin = UIImageView().then {
        $0.image = UIImage(systemName: "trash")
        $0.backgroundColor = .orange
    }

    // MARK: - Properties
    
    private var trashType: TrashType
    private lazy var explainString = "작성된 글은 \(trashType.rawValue)으로 이동합니다."
    
    // MARK: - Initializer
    
    init(trashType: TrashType) {
        self.trashType = trashType
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
    
    func setView() {
        view.backgroundColor = .white
    }
    
    func setConstraints() {
        let navigationHeight = 56 + UIDevice.current.safeAreaInset.top
        
        navigationView.addSubviews([navigationLabel, backButton])
        explanationView.addSubviews([explanationImage, explanationLabel])
        view.addSubviews([navigationView, explanationView, trash, trashBin, guideLabel])
        
        navigationLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-13)
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8 * SizeConstants.ScreenRatio)
            make.width.height.equalTo(36 * SizeConstants.ScreenRatio)
            make.bottom.equalToSuperview().offset(-10)
        }

        navigationView.snp.makeConstraints { make in
            make.top.width.equalToSuperview()
            make.height.equalTo(navigationHeight * SizeConstants.ScreenRatio)
        }
        
        explanationView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(16 * SizeConstants.ScreenRatio)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(48 * SizeConstants.ScreenRatio)
        }
        
        explanationImage.snp.makeConstraints { make in
            make.width.height.equalTo(24 * SizeConstants.ScreenRatio)
            make.leading.equalTo(24 * SizeConstants.ScreenRatio)
            make.centerY.equalToSuperview()
        }
        
        explanationLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-27 * SizeConstants.ScreenRatio)
            make.centerY.equalToSuperview()
        }
        
        trash.snp.makeConstraints { make in
            make.top.equalTo(explanationView.snp.bottom).offset(28 * SizeConstants.ScreenRatio)
            make.width.height.equalTo(88 * SizeConstants.ScreenRatio)
            make.centerX.equalToSuperview()
        }
        
        guideLabel.snp.makeConstraints { make in
            make.top.equalTo(trash.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        trashBin.snp.makeConstraints { make in
            make.top.equalTo(trash.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(400 * SizeConstants.ScreenRatio)
        }
    }
    
    // MARK: - Protocols
}
