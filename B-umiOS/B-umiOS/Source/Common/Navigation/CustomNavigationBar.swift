//
//  CustomNavigationBar.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/11/06.
//

import UIKit

enum RightButtonType {
    case none
    case plus
    case graph
    case check

    var icon: UIImage {
        switch self {
        case .none:
            return UIImage()
        case .plus:
            return UIImage.btnPlus
        case .graph:
            return UIImage.btnGraph
        case .check:
            return UIImage.btnCheck
        }
    }
}

class CustomNavigationBar: UIView {
    // MARK: - Components

    var titleLabel = UILabel().then {
        $0.font = .nanumSquareFont(type: .extraBold, size: 20)
        $0.textColor = .header
        $0.textAlignment = .center
    }

    lazy var backButton = UIButton().then {
        $0.setImage(UIImage.btnBack, for: .normal)
        $0.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    }

    lazy var rightButton = UIButton().then {
        $0.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    }

    let dividerView = UIView().then {
        $0.backgroundColor = .paper1
    }

    var title: String {
        didSet {
            titleLabel.text = title
        }
    }

    var rightButtonAction: (() -> Void)?
    var backButtonAction: (() -> Void)?

    // MARK: - Initializer

    init(title: String, backButtonAction: (() -> Void)? = nil, rightButtonAction: (() -> Void)? = nil, rightButtonIcon: RightButtonType = .none) {
        self.title = title

        defer {
            self.title = title
        }

        super.init(frame: .zero)

        self.backButtonAction = backButtonAction
        self.rightButtonAction = rightButtonAction

        rightButton.setImage(rightButtonIcon.icon, for: .normal)

        setConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func setConstraints() {
        addSubviews([titleLabel, rightButton, backButton, dividerView])

        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-18 * SizeConstants.screenHeightRatio)
        }

        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16 * SizeConstants.screenWidthRatio)
            make.bottom.equalToSuperview().offset(-10 * SizeConstants.screenHeightRatio)
            make.width.height.equalTo(36 * SizeConstants.screenWidthRatio)
        }

        rightButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16 * SizeConstants.screenWidthRatio)
            make.bottom.equalToSuperview().offset(-10 * SizeConstants.screenHeightRatio)
            make.width.height.equalTo(36 * SizeConstants.screenWidthRatio)
        }

        dividerView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }

    // MARK: - Actions

    @objc
    func didTapButton(_ sender: UIButton) {
        print("button clicked")

        switch sender {
        case backButton:
            if let backButtonAction = backButtonAction {
                backButtonAction()
            }
        case rightButton:
            if let rightButtonAction = rightButtonAction {
                rightButtonAction()
            }
        default:
            break
        }
    }
}
