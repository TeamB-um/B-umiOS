//
//  WritingViewController.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/04.
//

import UIKit

class WritingViewController: UIViewController {
    // MARK: - UIComponenets

    private let navigationView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private let navigationLabel = UILabel().then {
        $0.text = "글쓰기"
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
        $0.textColor = UIColor.header
    }
    
    private lazy var backButton = UIButton(type: .custom, primaryAction: UIAction(handler: { _ in
        self.navigationController?.popViewController(animated: true)
    })).then {
        $0.setImage(UIImage(named: "btnBack"), for: .normal)
    }
    
    private lazy var checkButton = UIButton(type: .custom, primaryAction: UIAction(handler: { _ in
        print("꾹..")
    })).then {
        $0.setImage(UIImage(named: "btnCheck"), for: .normal)
    }
    
    private let navigationDividerView = UIView().then {
        $0.backgroundColor = UIColor.paper1
    }
    
    private let tagCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collectionView
    }()

    private lazy var dividerView = UIView().then {
        $0.backgroundColor = self.style.dividerColor
    }
    
    private let titleTextField = UITextField().then {
        $0.placeholder = "제목"
        $0.font = UIFont.nanumSquareFont(type: .bold, size: 14)
    }
    
    private lazy var textFieldDividerView = UIView().then {
        $0.backgroundColor = self.style.dividerColor
    }
    
    private lazy var textFieldCountLabel = UILabel().then {
        $0.textColor = self.style.countColor
//        $0.font = UIFont. 폰트 변경됨..
        $0.text = "2/20"
    }
    
    private lazy var textView = UITextView().then {
        $0.textColor = self.style.textColor
        $0.font = UIFont.nanumSquareFont(type: .light, size: 14)
    }
    
    // MARK: - Properties

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
        setConstraint()
    }
    
    // MARK: - Actions
    
    // MARK: - Methods
    
    func setView() {
        view.backgroundColor = style.paperBgColor
    }
    
    func setConstraint() {
        navigationView.addSubviews([navigationLabel, backButton, checkButton])
        view.addSubviews([navigationView, navigationDividerView, tagCollectionView, dividerView, titleTextField, textFieldCountLabel, textFieldDividerView, textView])
        
        let screenSize = UIScreen.main.bounds
        
        navigationLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8 * screenSize.width / 375)
            make.width.height.equalTo(36 * screenSize.width / 375)
            make.centerY.equalToSuperview()
        }
        
        checkButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-8 * screenSize.width / 375)
            make.width.height.equalTo(36 * screenSize.width / 375)
            make.centerY.equalToSuperview()
        }
        
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.width.equalToSuperview()
            make.height.equalTo(64 * screenSize.width / 375)
        }
        
        tagCollectionView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(64 * screenSize.width / 375)
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(tagCollectionView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(24 * screenSize.width / 375)
            make.height.equalTo(48 * screenSize.width / 375)
        }

        textFieldDividerView.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(16 * screenSize.width / 375)
            make.height.equalTo(1)
        }

        textFieldCountLabel.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom)
            make.centerY.equalTo(titleTextField.snp.centerY)
            make.trailing.equalToSuperview().inset(24 * screenSize.width / 375)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(textFieldDividerView.snp.bottom)
            make.leading.trailing.equalTo(textFieldDividerView)
            make.bottom.equalToSuperview().offset(-48)
        }
    }
    
    // MARK: - Protocols
}
