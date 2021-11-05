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
    
    let popupView = UIView().then {
        $0.cornerRound(radius: 10)
        $0.backgroundColor = .white
        $0.setShadow(radius: 10, offset: CGSize(width: 0, height: 4), opacity: 0.3)
    }
    
    let backgroundButton = UIButton().then {
        $0.addTarget(self, action: #selector(closePopUp(_:)), for: .touchUpInside)
    }
    
    lazy var headerLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
        $0.textColor = .header
    }
        
    lazy var subLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 16)
        $0.textColor = .paper3
    }
    
    lazy var textField = UITextField().then {
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 14)
        $0.textColor = .header
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.layer.borderColor = UIColor.paper2.cgColor
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10 * SizeConstants.screenWidthRatio, height: self.view.frame.height))
        $0.leftViewMode = .always
        $0.text = self.trashBin?.name
        $0.addTarget(self, action: #selector(changeTextField(_:)), for: .editingChanged)
    }

    lazy var textNumberLabel = UILabel().then {
        $0.textColor = .green2Main
        $0.font = UIFont.systemFont(ofSize: 13)

        if let count = self.textField.text?.count {
            $0.text = "\(count)/\(limitLength)"
        }
    }

    lazy var boilerLabel = UILabel().then {
        $0.textColor = .error
        $0.text = "이름 중복!"
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.isHidden = true
    }
    
    let cancelButton = UIButton().then {
        $0.cornerRound(radius: 10)
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.paper2.cgColor
        $0.setTitleColor(.paper3, for: .normal)
        $0.setTitle("취소", for: .normal)
        $0.titleLabel?.font = UIFont.nanumSquareFont(type: .bold, size: 18)
        $0.addTarget(self, action: #selector(closePopUp(_:)), for: .touchUpInside)
    }
    
    let confirmButton = UIButton().then {
        $0.cornerRound(radius: 10)
        $0.backgroundColor = .disable
        $0.tintColor = .white
        $0.setTitle("확인", for: .normal)
        $0.titleLabel?.font = UIFont.nanumSquareFont(type: .bold, size: 18)
        $0.addTarget(self, action: #selector(didTapConfirmButton(_:)), for: .touchUpInside)
        $0.isEnabled = false
    }
    
    var stackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.alignment = .fill
        $0.spacing = 13
        $0.axis = .horizontal
    }
    
    // MARK: - Properties

    var method: PopUpMethod
    var trashBin: Category?
    var delegate: ChangeCategoryDataDelegate?
    
    static let identifier = "SeparatePopUpViewController"
    private let limitLength = 6
    var isHighligtedTextField = true {
        didSet {
            if isHighligtedTextField {
                textField.layer.borderColor = UIColor.error.cgColor
                textNumberLabel.textColor = .error
                confirmButton.backgroundColor = .disable
                confirmButton.isEnabled = false
                boilerLabel.isHidden = false
            }
            else {
                textField.layer.borderColor = UIColor.green2Main.cgColor
                textNumberLabel.textColor = .green2Main
                confirmButton.backgroundColor = .blue2Main
                confirmButton.isEnabled = true
                boilerLabel.isHidden = true
            }
        }
    }
    
    // MARK: - Initializer
    
    init(method: PopUpMethod, trashBin: Category? = nil) {
        self.method = method
        self.trashBin = trashBin
        
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
        setTextfield()
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
        switch method {
        case .add:
            if let name = textField.text {
                let category = CategoryRequest(name: name)
                
                ActivityIndicator.shared.startLoadingAnimation()
                
                CategoryService.shared.createCategory(category: category) { response in
                    ActivityIndicator.shared.stopLoadingAnimation()
                    
                    guard let result = response as? NetworkResult<Any> else { return }
                    
                    switch result {
                    case .success(let data):
                        guard let general = data as? GeneralResponse<CategoriesResponse> else { return }
                        
                        if let categories = general.data?.category {
                            self.delegate?.changeCategoryData(data: categories)
                            self.dismiss(animated: true, completion: nil)
                        }
                    case .requestErr(let message):
                        guard let msg = message as? ErrorMessage else { return }
                        
                        if msg == .conflict {
                            self.isHighligtedTextField = true
                        }
                    case .pathErr, .serverErr, .networkFail:
                        break
                    }
                }
            }
        case .modify:
            if let category = trashBin,
               let newName = textField.text
            {
                ActivityIndicator.shared.startLoadingAnimation()
                
                CategoryService.shared.updateCategory(id: category.id, category: CategoryRequest(name: newName)) { response in
                    ActivityIndicator.shared.stopLoadingAnimation()
                    
                    guard let result = response as? NetworkResult<Any> else { return }
                    
                    switch result {
                    case .success(let data):
                        guard let general = data as? GeneralResponse<CategoriesResponse> else { return }
                        
                        if let categories = general.data?.category {
                            self.delegate?.changeCategoryData(data: categories)
                            self.dismiss(animated: true, completion: nil)
                        }
                    case .requestErr(let message):
                        guard let msg = message as? ErrorMessage else { return }
                        
                        if msg == .conflict {
                            self.isHighligtedTextField = true
                        }
                    case .pathErr, .serverErr, .networkFail:
                        break
                    }
                }
            }
        }
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            let space = UIScreen.main.bounds.height / 2 - keyboardHeight + 30
            
            textField.layer.borderColor = UIColor.green2Main.cgColor
            popupView.snp.updateConstraints { make in
                make.centerY.equalToSuperview().offset(-space)
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        textField.layer.borderColor = UIColor.disable.cgColor
        
        popupView.snp.updateConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc func changeTextField(_ sender: UITextField) {
        if let text = textField.text {
            let length = text.count
            textNumberLabel.text = "\(length > limitLength ? limitLength : length)/\(limitLength)"
            
            isHighligtedTextField = false
            if length == 0 {
                confirmButton.isEnabled = false
                confirmButton.backgroundColor = UIColor.disable
            } else if length >= limitLength {
                let index = text.index(text.startIndex, offsetBy: limitLength)
                let newString = text[text.startIndex ..< index]
                textField.text = String(newString)
            } else {
                confirmButton.isEnabled = true
                confirmButton.backgroundColor = .blue2Main
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    // MARK: - Methods

    func setView() {
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        switch method {
        case .add:
            headerLabel.text = "분리수거 추가"
            subLabel.text = "분리수거함을 추가해 스트레스를 분류하세요."
        case .modify:
            headerLabel.text = "분리수거 수정"
            subLabel.text = "분리수거함의 이름을 수정해보세요."
        }
    }
    
    func setTextfield(){
        textField.becomeFirstResponder()
    }
}

// MARK: - Protocols

protocol ChangeCategoryDataDelegate {
    func changeCategoryData(data: [Category])
}
