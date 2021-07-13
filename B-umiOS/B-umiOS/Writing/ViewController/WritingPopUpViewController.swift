//
//  WritingPopUpViewController.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/08.
//

import UIKit

class WritingPopUpViewController: UIViewController {
    static let identifier = "WritingPopUpViewController"

    // MARK: - UIComponenets
    
    private let popUpView = UIView().then {
        $0.backgroundColor = .white
        $0.setShadow(radius: 20, offset: CGSize(width: 0, height: 4), opacity: 0.03)
        $0.cornerRound(radius: 10)
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "삭제 또는 분리수거"
        $0.textColor = .header
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
    }
    
    private lazy var closeButton = UIButton(frame: .zero, primaryAction: UIAction(handler: { _ in
        self.dismiss(animated: true, completion: nil)
    })).then {
        $0.setImage(UIImage(named: "btnCloseBlack"), for: .normal)
    }
    
    private let guideLabel = UILabel().then {
        $0.text = "삭제 시 설정 기한 이후 영구 삭제되고,\n보관 시 분리수거함에 저장됩니다."
        $0.numberOfLines = 0
        $0.lineSpacing(spacing: 7)
        $0.textAlignment = .center
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 14)
        $0.textColor = .paper3
    }
    
    private lazy var deleteButton = UIButton(primaryAction: UIAction(handler: { _ in
        self.dismiss(animated: true, completion: nil)
        self.popUpDelegate?.writingPopUpViewPush(trash: .trash)
    })).then {
        $0.setTitle("삭제", for: .normal)
        $0.titleLabel?.font = UIFont.nanumSquareFont(type: .bold, size: 18)
        $0.setTitleColor(.paper3, for: .normal)
        $0.cornerRound(radius: 10)
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
    }
    
    private lazy var archiveButton = UIButton(primaryAction: UIAction(handler: { _ in
        self.dismiss(animated: true, completion: nil)
        self.popUpDelegate?.writingPopUpViewPush(trash: .separate)
    })).then {
        $0.backgroundColor = .blue2Main
        $0.setTitle("보관", for: .normal)
        $0.titleLabel?.font = UIFont.nanumSquareFont(type: .bold, size: 18)
        $0.setTitleColor(.white, for: .normal)
        $0.cornerRound(radius: 10)
    }
    
    // MARK: - Properties
    
    var popUpDelegate: WritingPopUpDelegate?
    
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
        view.layer.backgroundColor = UIColor.black.withAlphaComponent(0.5).cgColor
    }
    
    func setConstraints() {
        view.addSubview(popUpView)
        popUpView.addSubviews([closeButton, titleLabel, guideLabel, deleteButton, archiveButton])
        
        popUpView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(343.0 / 375.0)
            make.height.equalTo(popUpView.snp.width).multipliedBy(226.0 / 343.0)
            make.center.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.width.height.equalTo(48 * SizeConstants.screenRatio)
            make.top.equalToSuperview().inset(4 * SizeConstants.screenRatio)
            make.trailing.equalToSuperview().inset(8 * SizeConstants.screenRatio)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(28 * SizeConstants.screenRatio)
            make.centerX.equalToSuperview()
        }
        
        guideLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(14 * SizeConstants.screenRatio)
            make.centerX.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24 * SizeConstants.screenRatio)
            make.bottom.equalToSuperview().offset(-32 * SizeConstants.screenRatio)
            make.width.equalTo(141 * SizeConstants.screenRatio)
            make.height.equalTo(50 * SizeConstants.screenRatio)
        }
        
        archiveButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-24 * SizeConstants.screenRatio)
            make.bottom.equalToSuperview().offset(-32 * SizeConstants.screenRatio)
            make.width.equalTo(141 * SizeConstants.screenRatio)
            make.height.equalTo(50 * SizeConstants.screenRatio)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view != popUpView {
            dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - Protocols
}
