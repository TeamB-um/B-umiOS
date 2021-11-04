//
//  NetworkErrorPopUpView.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/11/03.
//

import UIKit

typealias Completion = () -> Void

class NetworkErrorPopUpView: UIView {
    static let viewTag = 500

    // MARK: - UIComponenets
    
    let errorImage = UIImageView().then {
        $0.image = UIImage(named: "imgError")
        $0.contentMode = .scaleAspectFit
    }
    
    let errorLabel = UILabel().then {
        $0.text = "네트워크 연결이 불안정합니다.\n잠시 후 다시 시도해주세요."
        $0.textColor = .paper4
        $0.numberOfLines = 0
        $0.font = .nanumSquareFont(type: .regular, size: 14)
        $0.lineSpacing(spacing: 7)
        $0.textAlignment = .center
    }
    
    lazy var retryButton = UIButton().then {
        $0.backgroundColor = .blue2Main
        $0.setTitle("다시 시도", for: .normal)
        $0.titleLabel?.font = .nanumSquareFont(type: .bold, size: 18)
        $0.addTarget(self, action: #selector(didTapRetryButton(_:)), for: .touchUpInside)
        $0.cornerRound(radius: 10)
    }

    // MARK: - Properties
    
    private var retryActions = [Completion]()
    
    static var presentedView: Self? {
        let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
        return keyWindow?.viewWithTag(Self.viewTag) as? Self
    }

    // MARK: - Initializer
    
    override private init(frame: CGRect) {
        super.init(frame: frame)
        
        setView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Actions
    
    @objc
    func didTapRetryButton(_ sender: UIButton) {
        hidePopUpView()
    }
    
    // MARK: - Methods
    
    private func setView() {
        backgroundColor = .white
    }
    
    private func setConstraints() {
        addSubviews([errorImage, errorLabel, retryButton])
        
        errorImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(190 * SizeConstants.screenHeight / 812.0)
            make.width.equalTo(257 * SizeConstants.screenRatio)
            make.height.equalTo(328 * SizeConstants.screenHeight / 812.0)
            make.centerX.equalToSuperview()
        }
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(errorImage.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        retryButton.snp.makeConstraints { make in
            make.top.equalTo(errorLabel.snp.bottom).offset(20)
            make.width.equalTo(141.0 * SizeConstants.screenRatio)
            make.height.equalTo(50.0 * SizeConstants.screenRatio)
            make.centerX.equalToSuperview()
        }
    }
    
    static func showInKeyWindow(completion: Completion?) {
        guard let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        
        NetworkErrorPopUpView().showPopUpView(in: keyWindow) {
            completion?()
        }
    }
    
    static func appendCompletion(completion: Completion?) {
        guard let presentedView = self.presentedView else { return }
        guard let completion = completion else { return }
        
        presentedView.retryActions.append(completion)
    }
    
    func showPopUpView(in window: UIView, completion: Completion?) {
        if let completion = completion {
            retryActions.append(completion)
        }
        
        window.addSubview(self)
        snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        alpha = 0
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1
        }
    }
    
    func hidePopUpView() {
        UIView.animate(withDuration: 0.2) {
            self.alpha = 0
        } completion: { [weak self] _ in
            self?.retryActions.forEach { $0() }
            self?.retryActions.removeAll()
            
            self?.removeFromSuperview()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
}
