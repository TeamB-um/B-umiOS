//
//  MyWritingPopUpViewController.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/09.
//

import UIKit

class MyWritingPopUpViewController: UIViewController {
    // MARK: - UIComponenets
    
    private let popUpView = UIView().then {
        $0.backgroundColor = .white
        $0.cornerRound(radius: 10)
    }
    
    private lazy var closeButton = UIButton(primaryAction: UIAction(handler: { _ in
        self.dismiss(animated: true, completion: nil)
    })).then {
        $0.setImage(UIImage.btnCloseBlack, for: .normal)
        $0.tintColor = .header
    }
    
    private lazy var trashBinLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 14)
        $0.textColor = UIColor.blue2Main
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
        $0.textColor = .black
    }
    
    private lazy var dateLabel = UILabel().then {
        $0.textColor = .textGray
    }
    
    private lazy var contentLabel = UILabel().then {
        $0.textColor = .header
        $0.font = UIFont.nanumSquareFont(type: .light, size: 14)
        $0.numberOfLines = 0
    }
    
    private let scrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
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

    // MARK: - Actions
    
    // MARK: - Methods
    
    func setWritingData(data: Writing) {
        trashBinLabel.text = data.category.name
        trashBinLabel.textColor = SeparateStyle.color[data.category.index]
        
        titleLabel.text = data.title
        titleLabel.lineSpacing(spacing: 10)
        contentLabel.text = data.text
        contentLabel.lineSpacing(spacing: 9)

        let writtenDate = Date().ISOStringToDate(date: data.createdDate)
        let date = Date().ISODateToString(format: "yyyy.MM.dd(E)", date: writtenDate)
        self.dateLabel.text = date
        
    }
    
    func setConstraints() {
        contentView.addSubview(contentLabel)
        scrollView.addSubview(contentView)
        popUpView.addSubviews([closeButton, trashBinLabel, titleLabel, dateLabel, scrollView])
        view.addSubviews([popUpView])
        
        contentLabel.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView)
            make.width.equalTo(scrollView.snp.width)
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
        
        trashBinLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(24 * SizeConstants.screenRatio)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(trashBinLabel.snp.bottom).offset(14 * SizeConstants.screenRatio)
            make.leading.trailing.equalToSuperview().inset(24 * SizeConstants.screenRatio)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8 * SizeConstants.screenRatio)
            make.leading.equalTo(trashBinLabel.snp.leading)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(22 * SizeConstants.screenRatio)
            make.leading.equalTo(trashBinLabel.snp.leading)
            make.trailing.equalToSuperview().inset(24 * SizeConstants.screenRatio)
            make.bottom.equalToSuperview().inset(39 * SizeConstants.screenRatio)
        }
    }
    
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
