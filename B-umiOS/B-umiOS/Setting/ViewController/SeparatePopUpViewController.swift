//
//  TrashBinPopUpViewController.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/05.
//

import UIKit

enum PopUpMethod {
    case add
    case modify
}

class SeparatePopUpViewController: UIViewController {
    // MARK: - UIComponenets
    
    private let popupView = UIView().then {
        $0.cornerRound(radius: 10)
        $0.backgroundColor = .white
        $0.setShadow(radius: 10, offset: CGSize(width: 0, height: 4), opacity: 0.3)
    }
    
    private  let backgroundButton = UIButton().then {
        $0.addTarget(self, action: #selector(closePopUp(_:)), for: .touchUpInside)
    }
    
    private lazy var headerLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
        $0.textColor = .header
    }
        
    private lazy var subLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 16)
        $0.textColor = .paper3
    }
    
    private lazy var textfield = UITextField().then {
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 14)
        $0.textColor = .header
        $0.borderStyle = .roundedRect
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = UIColor.paper2.cgColor
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10 * SizeConstants.screenRatio, height: self.view.frame.height))
        $0.leftViewMode = .always
    }

    private lazy var textNumberLabel = UILabel().then {
        $0.textColor = .green2Main
        $0.text = "0/6"
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    
    private let cancelButton = UIButton().then {
        $0.cornerRound(radius: 10)
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.paper2.cgColor
        $0.setTitleColor(.paper3, for: .normal)
        $0.setTitle("취소", for: .normal)
        $0.titleLabel?.font = UIFont.nanumSquareFont(type: .bold, size: 18)
        $0.addTarget(self, action: #selector(closePopUp(_:)), for: .touchUpInside)
    }
    
    private let confirmButton = UIButton().then {
        $0.cornerRound(radius: 10)
        $0.backgroundColor = .blue2Main
        $0.tintColor = .white
        $0.setTitle("확인", for: .normal)
        $0.titleLabel?.font = UIFont.nanumSquareFont(type: .bold, size: 18)
    }
    
    private var stackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.alignment = .fill
        $0.spacing = 13
        $0.axis = .horizontal
    }
    
    // MARK: - Properties
    
//    var headerText : String = "header view"
//    var subText : String = "sub view"
//    var placeholder : String = "placeholder"
    var method : PopUpMethod?
    static let identifier = "SeparatePopUpViewController"
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setTextField()
        setView()
        setConstraint()
    }
    
    // MARK: - Actions
    
    @objc private func closePopUp(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Methods
    
    func setTextField(){
        textfield.delegate = self
    }
    
    func setView(){
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        switch method {
        case .add:
            self.headerLabel.text = "분리수거 추가"
            self.subLabel.text = "분리수거함을 추가해 스트레스를 분류하세요."
        case .modify:
            self.headerLabel.text = "분리수거 수정"
            self.subLabel.text = "분리수거함의 이름을 수정해보세요."
        case .none:
            break
        }
    }
    
    func setConstraint() {
        
        self.view.addSubviews([backgroundButton,popupView])

        popupView.addSubviews([headerLabel,subLabel,textfield,stackView,textNumberLabel])
        popupView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(238 * SizeConstants.screenRatio)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        backgroundButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        headerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(32 * SizeConstants.screenRatio)
        }

        subLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(70 * SizeConstants.screenRatio)
        }

        textfield.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24 * SizeConstants.screenRatio)
            make.top.equalTo(subLabel.snp.bottom).offset(34 * SizeConstants.screenRatio)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalTo(textfield.snp.bottom).offset(28 * SizeConstants.screenRatio)
            make.leading.trailing.equalToSuperview().inset(24 * SizeConstants.screenRatio)
            make.bottom.equalToSuperview().inset(32 * SizeConstants.screenRatio)
            make.height.equalTo(50 * SizeConstants.screenRatio)
        }
        
        textNumberLabel.snp.makeConstraints { make in
            make.centerY.equalTo(textfield)
            make.trailing.equalToSuperview().inset(36)
        }

        stackView.addArrangedSubview(cancelButton)
        stackView.addArrangedSubview(confirmButton)
    }
    
    // MARK: - Protocols
}

extension SeparatePopUpViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
     
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        DispatchQueue.main.async {
            self.textNumberLabel.text = "\(updatedText.count)/6"
            if(updatedText.count > 6){
                textField.layer.borderColor = UIColor.error.cgColor
                self.textNumberLabel.textColor = .error
                self.confirmButton.isEnabled = false
            }
            else{
                textField.layer.borderColor = UIColor.paper2.cgColor
                self.textNumberLabel.textColor = .green2Main
                self.confirmButton.isEnabled = true
            }
        }
        
        return updatedText.count < 12
    }
}
