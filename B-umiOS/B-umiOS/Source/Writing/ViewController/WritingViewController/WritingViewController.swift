//
//  WritingViewController.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/04.
//

import UIKit

protocol WritingPopUpDelegate {
    func writingPopUpViewPush(trash: TrashType, writing: WritingRequest)
}

class WritingViewController: UIViewController {
    // MARK: - UIComponenets

    let navigationView = UIView().then {
        $0.backgroundColor = .white
    }
    
    let navigationLabel = UILabel().then {
        $0.text = "글쓰기"
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
        $0.textColor = UIColor.header
    }
    
    lazy var backButton = UIButton(type: .custom, primaryAction: UIAction(handler: { _ in
        self.navigationController?.popViewController(animated: true)
    })).then {
        $0.setImage(UIImage.btnBack, for: .normal)
    }
    
    lazy var checkButton = UIButton().then {
        $0.setImage(UIImage.btnCheck.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.addTarget(self, action: #selector(didTapCheckButton(_:)), for: .touchUpInside)
        $0.tintColor = .disable
        $0.isUserInteractionEnabled = false
    }
    
    lazy var navigationDividerView = UIView().then {
        $0.backgroundColor = self.style.dividerColor
    }
    
    lazy var settingButton = UIButton().then {
        $0.setImage(UIImage.btnSetting, for: .normal)
        $0.addTarget(self, action: #selector(didTapSettingButton(_:)), for: .touchUpInside)
    }
    
    let guideImage = UIImageView().then {
        $0.image = UIImage.icArrow
    }
    
    let guideLabel = UILabel().then {
        $0.text = "카테고리를 추가해주세요!"
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 16)
        $0.textColor = UIColor.green2Main
    }
    
    let tagCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = .zero

        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.collectionViewLayout = layout
        
        $0.register(WritingTagCollectionViewCell.self, forCellWithReuseIdentifier: WritingTagCollectionViewCell.identifier)
    }
    
    lazy var leftGradientView = UIImageView().then {
        $0.image = UIImage.writing1GradientEnd.withRenderingMode(.alwaysTemplate)
        $0.tintColor = style.paperBgColor
        $0.alpha = 0
    }

    lazy var righrGradientView = UIImageView().then {
        $0.image = UIImage.writing1GradientRight.withRenderingMode(.alwaysTemplate)
        $0.tintColor = style.paperBgColor
    }

    lazy var dividerView = UIView().then {
        $0.backgroundColor = self.style.dividerColor
    }
    
    lazy var titleTextField = UITextField().then {
        $0.autocorrectionType = .no
        $0.attributedPlaceholder = NSAttributedString(string: "제목", attributes: [NSAttributedString.Key.foregroundColor: self.style.placeholderColor, NSAttributedString.Key.font: UIFont.nanumSquareFont(type: .bold, size: 14)])
        $0.textColor = self.style.textColor
        $0.font = UIFont.nanumSquareFont(type: .bold, size: 14)
        
        $0.delegate = self
        $0.addTarget(self, action: #selector(changeTextField(_:)), for: .editingChanged)
        $0.becomeFirstResponder()
    }
    
    lazy var textFieldDividerView = UIView().then {
        $0.backgroundColor = self.style.dividerColor
    }
    
    lazy var textFieldCountLabel = UILabel().then {
        $0.textColor = self.style.countColor
        $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        $0.text = "0/20"
    }
    
    lazy var textView = UITextView().then {
        $0.backgroundColor = .clear
        $0.text = self.placeholder
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 8
        let attributes = [NSAttributedString.Key.paragraphStyle: style, NSAttributedString.Key.foregroundColor: self.style.placeholderColor, NSAttributedString.Key.font: UIFont.nanumSquareFont(type: .light, size: 14)]
        $0.attributedText = NSAttributedString(string: $0.text, attributes: attributes)
        
        $0.autocorrectionType = .no
        $0.delegate = self
    }
    
    // MARK: - Properties

    let placeholder = "당신의 스트레스를 적어주세요"
    let style: WritingStyle
    var tag: [Category] = []
    let limitLength = 20
    var tagSelectedIdx = 0
    
    // MARK: - Initializer

    init(style: WritingStyle) {
        self.style = style
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
        setCollectionView()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.post(name: Notification.Name.TabBarHide, object: nil)
        
        fetchCategoriesData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.post(name: Notification.Name.TabBarShow, object: nil)
    }
    
    // MARK: - Actions
    
    @objc
    func didTapSettingButton(_ sender: UIButton) {
        navigationController?.pushViewController(SettingSeparateViewController(), animated: true)
    }
    
    @objc
    func didTapCheckButton(_ sender: UIButton) {
        guard let idx = tagCollectionView.indexPathsForSelectedItems?.first?.row else { return }
        let writing = WritingRequest(title: titleTextField.text ?? nil, text: textView.text ?? "", categoryID: tag[idx].id, isWriting: true)
        
        let popUpViewController = WritingPopUpViewController(writing: writing)
        popUpViewController.modalPresentationStyle = .overCurrentContext
        popUpViewController.modalTransitionStyle = .crossDissolve
        popUpViewController.popUpDelegate = self
        
        present(popUpViewController, animated: true, completion: nil)
    }
    
    @objc
    func changeTextField(_ sender: UITextField) {
        if let text = titleTextField.text {
            let length = text.count
            textFieldCountLabel.text = "\(length > limitLength ? limitLength : length)/\(limitLength)"
            
            if length >= limitLength {
                let index = text.index(text.startIndex, offsetBy: limitLength)
                let newString = text[text.startIndex ..< index]
                titleTextField.text = String(newString)
            }
        }
    }
    
    // MARK: - Methods
    
    func setView() {
        view.backgroundColor = style.paperBgColor
    }
    
    func setTextView() {
        // FIXME: - else if 조건 변경
        
        if textView.text.isEmpty {
            textView.text = placeholder
            textView.textColor = style.placeholderColor
        } else if textView.text == placeholder {
            textView.text = ""
            textView.textColor = style.textColor
        }
    }
    
    func setCollectionView() {
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
    }
    
    func fetchCategoriesData() {
        ActivityIndicator.shared.startLoadingAnimation()

        CategoryService.shared.fetchCategories { response in
            ActivityIndicator.shared.stopLoadingAnimation()
            
            guard let result = response as? NetworkResult<Any> else { return }
            
            switch result {
            case .success(let data):
                guard let result = data as? GeneralResponse<CategoriesResponse> else { return }
                self.tag = result.data?.category ?? []
                self.guideLabel.isHidden = self.tag.count != 0
                self.guideImage.isHidden = self.tag.count != 0
                self.tagCollectionView.reloadData()
                self.tagCollectionView.selectItem(at: IndexPath(row: self.tagSelectedIdx, section: 0), animated: false, scrollPosition: .centeredHorizontally)
            case .requestErr, .pathErr, .serverErr, .networkFail:
                print("error")
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}