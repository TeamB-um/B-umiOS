//
//  MyWritingPopUpViewController.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/09.
//

import UIKit

class MyWritingPopUpViewController: UIViewController {
    // MARK: - UIComponenets
    
    private let popUpView = UIImageView().then {
        $0.backgroundColor = .clear
        $0.isUserInteractionEnabled = true
    }
    
    private lazy var closeButton = UIButton(primaryAction: UIAction(handler: { _ in
        self.dismiss(animated: true, completion: nil)
    })).then {
        $0.setImage(UIImage.btnCloseBlack, for: .normal)
        $0.tintColor = .header
    }
    
    let trashBinTagView = UIView()
    
    private lazy var trashBinLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .bold, size: 14)
        $0.textColor = UIColor.blue2Main
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
        $0.textColor = .header
    }
    
    private lazy var dateLabel = UILabel().then {
        $0.textColor = .paper3
        $0.font = .systemFont(ofSize: 15, weight: .regular)
    }
    
    private lazy var contentLabel = UILabel().then {
        $0.textColor = .header
        $0.font = UIFont.nanumSquareFont(type: .light, size: 18)
        $0.numberOfLines = 0
    }
    
    private let scrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = true
    }
    
    private let contentView = UIView()
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    init(writing: Writing) {
        super.init(nibName: nil, bundle: nil)
        setWritingData(data: writing)
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
    
    override func viewDidLayoutSubviews() {
        trashBinTagView.cornerRounds()
    }

    // MARK: - Actions
    
    // MARK: - Methods
    
    // FIXME: - 서버에서 Writing Model 변경 예정!
    
    func setWritingData(data: Writing) {
        let style = WritingStyle(rawValue: 3) ?? WritingStyle.paper1
        let writtenDate = Date().ISOStringToDate(date: data.createdDate)
        let date = Date().ISODateToString(format: "yyyy.MM.dd (E)", date: writtenDate)
        
        trashBinTagView.backgroundColor = .category
        
        trashBinLabel.text = data.category.name
        trashBinLabel.textColor = SeparateStyle.color[data.category.index]
        
        titleLabel.text = data.title
        titleLabel.textColor = style.textColor
        titleLabel.lineSpacing(spacing: 10)
        
        contentLabel.text = data.text
        contentLabel.textColor = style.textColor
        contentLabel.lineSpacing(spacing: 9)
        
        dateLabel.text = date
        dateLabel.textColor = style.dateTextColor
        
        popUpView.image = style.myWritingPaperImage
        closeButton.tintColor = style.textColor
    }
    
    func setConstraints() {
        contentView.addSubview(contentLabel)
        scrollView.addSubview(contentView)
        trashBinTagView.addSubview(trashBinLabel)
        popUpView.addSubviews([closeButton, trashBinTagView, titleLabel, dateLabel, scrollView])
        view.addSubviews([popUpView])
        
        contentLabel.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
        }
        
        popUpView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(343 * SizeConstants.screenRatio)
            make.height.equalTo(593 * SizeConstants.screenRatio)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(4 * SizeConstants.screenRatio)
            make.trailing.equalToSuperview().inset(4 * SizeConstants.screenRatio)
            make.width.height.equalTo(48 * SizeConstants.screenRatio)
        }
        
        trashBinTagView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(24 * SizeConstants.screenRatio)
            make.width.equalTo(trashBinLabel.snp.width).offset(22)
            make.height.equalTo(trashBinLabel.snp.height).offset(10)
        }
        
        trashBinLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(trashBinTagView.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(24 * SizeConstants.screenRatio)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(9)
            make.leading.equalTo(titleLabel.snp.leading)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(24 * SizeConstants.screenRatio)
            make.bottom.equalToSuperview().inset(70)
        }
    }
    
    func setView() {
        view.layer.backgroundColor = UIColor.black.withAlphaComponent(0.6).cgColor
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view != popUpView {
            dismiss(animated: true, completion: nil)
        }
    }
}
