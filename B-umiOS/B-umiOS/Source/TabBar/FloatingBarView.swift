//
//  FloatingBarView.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/01.
//

import SnapKit
import UIKit

protocol FloatingBarViewDelegate: AnyObject {
    func floatingBarDidTapBarItem(selectindex: Int)
}

class FloatingBarView: UIView {
    // MARK: - UIComponenets

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.alignment = .center
        stackView.distribution = .fillEqually

        return stackView
    }()

    // MARK: - Properties

    var buttons: [UIButton] = []
    weak var delegate: FloatingBarViewDelegate?

    // MARK: - Initializer

    init(_ items: [String]) {
        super.init(frame: .zero)
        backgroundColor = .white

        setStackView(items)
        updateUI(selectedIndex: 0)
        setContraint()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - LifeCycle

    override func layoutSubviews() {
        super.layoutSubviews()

        cornerRounds()
        setShadow(radius: 16, offset: CGSize(width: 0, height: 4), opacity: 0.08)
    }

    // MARK: - Actions

    @objc
    func didTapBarItem(_ sender: UIButton) {
        delegate?.floatingBarDidTapBarItem(selectindex: sender.tag)
        updateUI(selectedIndex: sender.tag)
    }

    // MARK: - Methods

    func setStackView(_ items: [String]) {
        for (index, item) in items.enumerated() {
            let normalImage = UIImage(named: item)
            let selectedImage = UIImage(named: item)

            let button = createButton(normalImage: normalImage ?? UIImage(), selectedImage: selectedImage ?? UIImage(), index: index)
            buttons.append(button)
        }
    }

    func createButton(normalImage: UIImage, selectedImage: UIImage, index: Int) -> UIButton {
        let button = UIButton()
        button.setImage(normalImage, for: .normal)
        button.setImage(selectedImage.withTintColor(.blue2Main), for: .selected)
        button.tag = index
        button.adjustsImageWhenHighlighted = false
        button.addTarget(self, action: #selector(didTapBarItem(_:)), for: .touchUpInside)

        return button
    }

    func updateUI(selectedIndex: Int) {
        for (index, button) in buttons.enumerated() {
            if index == selectedIndex {
                button.isSelected = true
            } else {
                button.isSelected = false
            }
        }
    }

    func setContraint() {
        addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.leading.trailing.equalToSuperview().inset(18)
        }
    }
}
