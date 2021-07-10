//
//  MyWritingPopUpViewController.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/09.
//

import UIKit

/// 사용은 이렇게.. 해주세요 (구조체 임시 - 서버 확정 후 변경)

// let pop = MyWritingPopUpViewController(writing: DummyWriting(trashBin: "웅앵", title: "아아아아", date: Date(timeIntervalSince1970: .init()), content: "당신의 고민을 적어주세요.당신의 고민을 적어주세요."))
// pop.modalTransitionStyle = .crossDissolve
// pop.modalPresentationStyle = .overCurrentContext
//
// present(pop, animated: true, completion: nil)

struct DummyWriting {
    var trashBin: String
    var title: String
    var date: Date
    var content: String
}

class MyWritingPopUpViewController: UIViewController {
    // MARK: - UIComponenets
    
    private let popUpView = UIView().then {
        $0.backgroundColor = .white
        $0.cornerRound(radius: 10)
    }
    
    private lazy var closeButton = UIButton(primaryAction: UIAction(handler: { _ in
        self.dismiss(animated: true, completion: nil)
    })).then {
        $0.setImage(UIImage(named: "btnCloseBlack"), for: .normal)
        $0.tintColor = .header
    }
    
    private lazy var trashBinLabel = UILabel().then {
        $0.text = self.writing.trashBin
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 14)
        $0.textColor = UIColor.blue2Main
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.text = self.writing.title
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
        $0.textColor = .black
    }
    
    private lazy var dateLabel = UILabel().then {
        $0.text = Date().dateToString(format: "yyyy년 MM월 dd일 (E)", date: self.writing.date)
        $0.textColor = .textGray
    }
    
    private lazy var contentLabel = UILabel().then {
        $0.textColor = .header
        $0.font = UIFont.nanumSquareFont(type: .light, size: 14)
        $0.numberOfLines = 0
        $0.text = self.writing.content
        $0.lineSpacing(spacing: 9)
    }
    
    private let scrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
    }
    
    private let contentView = UIView()
    
    // MARK: - Properties
    
    private let writing: DummyWriting
    
    // MARK: - Initializer
    
    init(writing: DummyWriting) {
        self.writing = writing
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
            make.leading.equalTo(trashBinLabel.snp.leading)
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
