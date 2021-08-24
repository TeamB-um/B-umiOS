//
//  WritingPopUpViewController.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/08.
//

import UIKit

class WritingPopUpViewController: UIViewController {
    // MARK: - UIComponenets
    
    let popUpView = UIView().then {
        $0.backgroundColor = .white
        $0.setShadow(radius: 20, offset: CGSize(width: 0, height: 4), opacity: 0.03)
        $0.cornerRound(radius: 10)
    }
    
    let titleLabel = UILabel().then {
        $0.text = "삭제 또는 분리수거"
        $0.textColor = .header
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
    }
    
    lazy var closeButton = UIButton(frame: .zero, primaryAction: UIAction(handler: { _ in
        self.dismiss(animated: true, completion: nil)
    })).then {
        $0.setImage(UIImage.btnCloseBlack, for: .normal)
    }
    
    let guideLabel = UILabel().then {
        $0.text = "삭제 시 설정 기한 이후 영구 삭제되고,\n보관 시 분리수거함에 저장됩니다."
        $0.numberOfLines = 0
        $0.lineSpacing(spacing: 7)
        $0.textAlignment = .center
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 14)
        $0.textColor = .paper3
    }
    
    lazy var deleteButton = UIButton(primaryAction: UIAction(handler: { _ in
        self.dismiss(animated: true, completion: nil)
        
        self.writingRequest.isWriting = false
        self.popUpDelegate?.writingPopUpViewPush(trash: .trash(Int.random(in: 0 ... 2)), writing: self.writingRequest)
    })).then {
        $0.setTitle("삭제", for: .normal)
        $0.titleLabel?.font = UIFont.nanumSquareFont(type: .bold, size: 18)
        $0.setTitleColor(.paper3, for: .normal)
        $0.cornerRound(radius: 10)
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor(red: 210 / 255, green: 210 / 255, blue: 210 / 255, alpha: 1).cgColor
    }
    
    lazy var archiveButton = UIButton(primaryAction: UIAction(handler: { _ in
        self.dismiss(animated: true, completion: nil)
        
        self.writingRequest.isWriting = true
        self.popUpDelegate?.writingPopUpViewPush(trash: .separate, writing: self.writingRequest)
    })).then {
        $0.backgroundColor = .blue2Main
        $0.setTitle("보관", for: .normal)
        $0.titleLabel?.font = UIFont.nanumSquareFont(type: .bold, size: 18)
        $0.setTitleColor(.white, for: .normal)
        $0.cornerRound(radius: 10)
    }
    
    // MARK: - Properties
    
    static let identifier = "WritingPopUpViewController"
    var popUpDelegate: WritingPopUpDelegate?
    var writingRequest: WritingRequest
    
    // MARK: - Initializer
    
    init(writing: WritingRequest) {
        self.writingRequest = writing
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
        view.layer.backgroundColor = UIColor.black.withAlphaComponent(0.5).cgColor
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view != popUpView {
            dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - Protocols
}
