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
        
        collectionView.register(MyWritingCollectionViewCell.self, forCellWithReuseIdentifier: MyWritingCollectionViewCell.identifier)
        
        collectionView.register(ButtonSectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ButtonSectionView.identifier)
        
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
    
    
    
    
    
    private lazy var setDateLabel = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
        $0.textColor = .header
        $0.text = "기간 설정"
    }
    
    //토글
    
    
    
    
    
    
    private var stackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.spacing = 13
        $0.axis = .horizontal
    }
    
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
        

        popupView.addSubviews([rect,headerLabel,subLabel,textfield,stackView])
        popupView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.top.equalToSuperview().inset(429)
            make.leading.trailing.equalToSuperview()
        }
        
        backgroundButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        headerLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.top.equalToSuperview().inset(32)
        }

        subLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(headerLabel.snp.bottom).offset(8)
        }

        textfield.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(subLabel.snp.bottom).offset(28)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalTo(textfield.snp.bottom).offset(28)
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(32)
            make.height.equalTo(50)
        }
        

        stackView.addArrangedSubview(confirmButton)
    }
}
    // MARK: - Protocols
    // MARK: - Extensions

extension MyWritingPopUpViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //서버에서 휴지통 개수 계산해서 여따 넣어라
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryTagCollectionViewCell.identifier, for: indexPath) as? CategoryTagCollectionViewCell else { return UICollectionViewCell() }
        
        
        
        return cell
    }
    
}

extension MyWritingPopUpViewController: UICollectionViewDelegateFlowLayout {
    
}
