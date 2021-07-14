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
    
    private let backgroundButton = UIButton().then {
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
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.layer.borderColor = UIColor.paper2.cgColor
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10 * SizeConstants.screenRatio, height: self.view.frame.height))
        $0.leftViewMode = .always
    }

    private lazy var textNumberLabel = UILabel().then {
        $0.textColor = .green2Main
        $0.text = "0/6"
        $0.font = UIFont.systemFont(ofSize: 13)
    }

    private lazy var boilerLabel = UILabel().then {
        $0.textColor = .error
        $0.text = "이름 중복!"
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.isHidden = true
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
        $0.addTarget(self, action: #selector(didTapConfirmButton(_:)), for: .touchUpInside)
    }
    
    private var stackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.alignment = .fill
        $0.spacing = 13
        $0.axis = .horizontal
    }
    
    // MARK: - Properties

    var method: PopUpMethod?
    static let identifier = "SeparatePopUpViewController"
    private let limitLength = 6
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setTextField()
        setView()
        setConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Actions
    
    @objc private func closePopUp(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapConfirmButton(_ sender: UIButton) {
        // 확인 호출 (add, modify method에 따라 구분)
        
        // .success => ok일시
//        self.dismiss(animated: true, completion: nil)
        
        // .중복 일시
//        DispatchQueue.main.async {
//            self.textfield.layer.borderColor = UIColor.error.cgColor
//            self.textNumberLabel.textColor = .error
//            self.confirmButton.backgroundColor = .gray
//            self.confirmButton.isEnabled = false
//            self.boilerLabel.isHidden = false
//        }
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            let space = UIScreen.main.bounds.height / 2 - keyboardHeight + 30
            
            popupView.snp.updateConstraints { make in
                make.centerY.equalToSuperview().offset(-space)
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        popupView.snp.updateConstraints { make in
            make.center.equalToSuperview()
        }
    }

    // MARK: - Methods
    
    func setTextField() {
        textfield.delegate = self
        textfield.becomeFirstResponder()
    }
    
    func setView() {
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        switch method {
        case .add:
            headerLabel.text = "분리수거 추가"
            subLabel.text = "분리수거함을 추가해 스트레스를 분류하세요."
        case .modify:
            headerLabel.text = "분리수거 수정"
            subLabel.text = "분리수거함의 이름을 수정해보세요."
        case .none:
            break
        }
    }
    
    func setConstraint() {
        view.addSubviews([backgroundButton, popupView])

        popupView.addSubviews([headerLabel, subLabel, textfield, stackView, textNumberLabel, boilerLabel])
        
        popupView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(343.0 / 375.0)
            make.height.equalTo(popupView.snp.width).multipliedBy(271.0 / 343.0)
            make.center.equalToSuperview()
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
            make.height.equalTo(40 * SizeConstants.screenRatio)
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

        boilerLabel.snp.makeConstraints { make in
            make.centerY.equalTo(textNumberLabel)
            make.trailing.equalTo(textNumberLabel.snp.leading).offset(-8 * SizeConstants.screenRatio)
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
        let length = (textField.text?.count)! - range.length + string.count
        
        textNumberLabel.text = "\(length > limitLength ? limitLength : length)/\(limitLength)"
        
        return updatedText.count <= limitLength
    }
}

extension SeparatePopUpViewController: TextDelegate {
    func sendData(name: String) {
        DispatchQueue.main.async {
            self.textfield.text = name
        }
    }
}

protocol TextDelegate {
    func sendData(name: String)
}
