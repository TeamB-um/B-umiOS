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
    
    private let closeButton = UIButton().then {
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
    
    private let deleteButton = UIButton().then {
        $0.setTitle("삭제", for: .normal)
        $0.setTitleColor(.paper3, for: .normal)
        $0.cornerRound(radius: 10)
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1).cgColor
    }
    
    private let archiveButton = UIButton().then {
        $0.backgroundColor = .blue2Main
        $0.setTitle("보관", for: .normal)
        $0.cornerRound(radius: 10)
    }
    
    // MARK: - Properties
    
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
            make.width.equalTo(343 * SizeConstants.ScreenRatio)
            make.height.equalTo(226 * SizeConstants.ScreenRatio)
            make.center.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.width.height.equalTo(48 * SizeConstants.ScreenRatio)
            make.top.equalToSuperview().inset(4 * SizeConstants.ScreenRatio)
            make.trailing.equalToSuperview().inset(8 * SizeConstants.ScreenRatio)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(28 * SizeConstants.ScreenRatio)
            make.centerX.equalToSuperview()
        }
        
        guideLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10 * SizeConstants.ScreenRatio)
            make.centerX.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24 * SizeConstants.ScreenRatio)
            make.bottom.equalToSuperview().offset(-32 * SizeConstants.ScreenRatio)
            make.width.equalTo(141 * SizeConstants.ScreenRatio)
            make.height.equalTo(50 * SizeConstants.ScreenRatio)
        }
        
        archiveButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-24 * SizeConstants.ScreenRatio)
            make.bottom.equalToSuperview().offset(-32 * SizeConstants.ScreenRatio)
            make.width.equalTo(141 * SizeConstants.ScreenRatio)
            make.height.equalTo(50 * SizeConstants.ScreenRatio)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view != popUpView {
            dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - Protocols
}
