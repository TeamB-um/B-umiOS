//
//  MyWritingPopUpViewController.swift
//  B-umiOS
//
//  Created by kong on 2021/07/07.
//
import Then
import SnapKit
import UIKit

class MyWritingPopUpViewController: UIViewController {
    // MARK: - UIComponenets
    
    private let popupView = UIView().then {
        $0.cornerRound(radius: 10)
        $0.backgroundColor = .white
        $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
    }
    
    //확인버튼
    private let confirmButton = UIButton().then {
        $0.cornerRound(radius: 10)
        $0.backgroundColor = .blue2Main
        $0.tintColor = .white
        $0.setTitle("확인", for: .normal)
    }
    
    //카테고리 컬렉션뷰
    private lazy var categoryTagCollecitonView : UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        
        collectionView.register(WritingTagCollectionViewCell.self, forCellWithReuseIdentifier: WritingTagCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    private lazy var categoryLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
        $0.textColor = .header
        $0.text = "카테고리"
    }
    
    //타임피커

    
//    private lazy var setDateLabel = UILabel().then {
//        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
//        $0.textColor = .header
//        $0.text = "기간 설정"
//    }
    
    //토글
    
    
    
    
    
//
//    private var stackView = UIStackView().then {
//        $0.distribution = .fillEqually
//        $0.spacing = 13
//        $0.axis = .horizontal
//    }
    
    private let rect = UIView().then {
        $0.backgroundColor = .paper1
        $0.cornerRound(radius: 10)
    }
    
    private  let backgroundButton = UIButton().then {
        $0.addTarget(self, action: #selector(didTapBackgroundButton(_:)), for: .touchUpInside)
    }
    
    // MARK: - Properties
    
    var subText : String = "sub view"
    var placeholder : String = "placeholder"
    var tag: [String] = ["인간관계", "취업", "날파리", "거지챌린지", "아르바이트", "부장님"]

    
    // MARK: - Initializer
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        setConstraint()
    }
    
    // MARK: - Actions
    
    @objc  private func didTapBackgroundButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Methods
    
    func setConstraint() {
        
        self.view.addSubviews([backgroundButton,popupView])
        
        popupView.addSubviews([confirmButton, categoryTagCollecitonView, categoryLabel])
        
        confirmButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(32)
            make.height.equalTo(50)
        }
        
        popupView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.top.equalToSuperview().inset(429)
            make.leading.trailing.equalToSuperview()
        }
        
        backgroundButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        categoryTagCollecitonView.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(20)
            make.bottom.equalTo(confirmButton.snp.top).offset(30)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.leading.equalTo(confirmButton)
        }

    }
}

    // MARK: - Protocols
    // MARK: - Extensions
extension MyWritingPopUpViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        label.text = tag[indexPath.row]
        label.font = UIFont.nanumSquareFont(type: .regular, size: 16)
        label.sizeToFit()

        return CGSize(width: label.bounds.width + 32, height: label.bounds.height + 18)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
}

// MARK: - UICollectionViewDataSource

extension MyWritingPopUpViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tag.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WritingTagCollectionViewCell.identifier, for: indexPath) as? WritingTagCollectionViewCell else { return UICollectionViewCell() }

        cell.setTagLabel(tag: tag[indexPath.row])
        return cell
    }
}
