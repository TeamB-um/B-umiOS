//
//  WritingViewController.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/04.
//

import UIKit

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
        $0.setImage(UIImage(named: "btnBack"), for: .normal)
    }
    
    lazy var checkButton = UIButton(type: .custom, primaryAction: UIAction(handler: { _ in
        print("꾹..")
    })).then {
        $0.setImage(UIImage(named: "btnCheck"), for: .normal)
    }
    
    lazy var navigationDividerView = UIView().then {
        $0.backgroundColor = self.style.dividerColor
    }
    
    lazy var settingButton = UIButton().then {
        $0.setImage(UIImage(named: "btnSetting"), for: .normal)
        $0.addTarget(self, action: #selector(didTapSettingButton(_:)), for: .touchUpInside)
    }
    
    let tagCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(WritingTagCollectionViewCell.self, forCellWithReuseIdentifier: WritingTagCollectionViewCell.identifier)
        
        return collectionView
    }()

    lazy var dividerView = UIView().then {
        $0.backgroundColor = self.style.dividerColor
    }
    
    lazy var titleTextField = UITextField().then {
        $0.placeholder = "제목"
        $0.textColor = self.style.textColor
        $0.font = UIFont.nanumSquareFont(type: .bold, size: 14)
    }
    
    lazy var textFieldDividerView = UIView().then {
        $0.backgroundColor = self.style.dividerColor
    }
    
    lazy var textFieldCountLabel = UILabel().then {
        $0.textColor = self.style.countColor
        $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        $0.text = "2/20"
    }
    
    lazy var textView = UITextView().then {
        $0.backgroundColor = .clear
        $0.delegate = self
        $0.text = self.placeholder
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 8
        let attributes = [NSAttributedString.Key.paragraphStyle: style, NSAttributedString.Key.foregroundColor: self.style.textColor, NSAttributedString.Key.font: UIFont.nanumSquareFont(type: .light, size: 14)]
        $0.attributedText = NSAttributedString(string: $0.text, attributes: attributes)
    }
    
    // MARK: - Properties

    let placeholder = "당신의 스트레스를 적어주세요"
    let style: WritingStyle
    
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
        setConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.post(name: Notification.Name.TabBarHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.post(name: Notification.Name.TabBarShow, object: nil)
    }
    
    // MARK: - Actions
    
    @objc
    func didTapSettingButton(_ sender: UIButton) {
        /// settingVC로 이동 ...
    }
    
    // MARK: - Methods
    
    func setView() {
        view.backgroundColor = style.paperBgColor
    }
    
    func setTextView() {
        if textView.text.isEmpty {
            textView.text = placeholder
        } else if textView.text == placeholder {
            textView.text = ""
        }
    }
    
    func setCollectionView() {
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
    }
    
    // MARK: - Protocols
}

extension WritingViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        setTextView()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            setTextView()
        }
    }
}
