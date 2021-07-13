//
//  MyWritingViewController.swift
//  B-umiOS
//
//  Created by kong on 2021/07/04.
//

import UIKit

class MyWritingViewController: UIViewController {
    // MARK: - UIComponenets
    
    private lazy var myWritingCollectionView : UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionHeadersPinToVisibleBounds = true
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .background
        
        collectionView.register(MyWritingCollectionViewCell.self, forCellWithReuseIdentifier: MyWritingCollectionViewCell.identifier)
        
        collectionView.register(ButtonSectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ButtonSectionView.identifier)
        collectionView.allowsMultipleSelection = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    // MARK: - Properties
    var deleteButtonIsSelected: Bool = false
    var myWritingParentViewcontroller: UIViewController?
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraint()
        addObservers()
    }
    
    // MARK: - Actions
    
    // MARK: - Methods
    
    func setConstraint(){
        view.addSubview(myWritingCollectionView)
        
        myWritingCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    func addObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(deleteButtonClicked), name: NSNotification.Name.isDeleteButtonSelected, object: nil)
    }
    
    @objc func deleteButtonClicked(noti : NSNotification){
        if let isClicked = noti.object as? Bool {
            deleteButtonIsSelected.toggle()
            self.myWritingCollectionView.reloadData()
        }
    }
    // MARK: - Protocols
}
    // MARK: - Extension

extension MyWritingViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 17
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyWritingCollectionViewCell.identifier, for: indexPath) as? MyWritingCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setShadow(radius: 20, offset: CGSize(width: 0, height: 4), opacity: 0.03)
        
        if deleteButtonIsSelected {
            cell.emptyCheckButton.isHidden = false
        } else {
            cell.emptyCheckButton.isHidden = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ButtonSectionView.identifier, for: indexPath)
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !deleteButtonIsSelected {
        let popUpVC = MyWritingPopUpViewController(writing: DummyWriting(trashBin: "날파리", title: "제목", date: Date(), content: "이 새벽을 비추는 초생달 오감보다 생생한 육감의 세계로 보내주는 푸르고 투명한 파랑새술취한 몸이 잠든 이 거릴 휘젓고 다니다 만나는 마지막 신호등이 뿜는 붉은 신호를 따라 회색 거리를 걸어서 가다보니 좀 낯설어 보이는 그녀가 보인적 없던 눈물로 나를 반겨 태양보다 뜨거워진 나 그녀의 가슴에 안겨 창가로 비친 초승달 침대가로 날아온 파랑새가 전해준그녀의 머리핀을 보고 눈물이 핑돌아 순간 픽하고 나가버린 시야는 오감의 정전을 의미 이미 희미해진 내 혼은 보라빛 눈을 가진 아름다운 그녀를 만나러 파랑새를 따라 몽환의 숲으로 나는 날아가 단 둘만의 가락에 오감의 나락에 아픔은 잊어버리게 내 손은 그녀의 치마자락에 하늘에 날린 아드레날린 하나도 화날일 없는 이곳은 그녀와 나 파랑새만이 육감의 교감으로 오감따위는 초월해버린 기적의 땅 얼만큼의 시간이 지났는지 몰라 허나 한숨자고 깨어봐도 여전히 니 품안이라는게 꼬집어봐도 꿈이 아니라는게 행복해 만족해 잠시보이는 무지개같은 사랑이라 해도 흩어질 잊혀질 구름이라 해도 터질듯해 내 감정은 머리로는 못해 이해를 스위치가 내려진 세상이 정신 건강의 도우미 그녈 마시고 취할거야 번지수는 몽환의 숲"))
        
        popUpVC.modalTransitionStyle = .crossDissolve
            popUpVC.modalPresentationStyle = .overCurrentContext
            if let parentVC = view.superview?.parentViewController {
                parentVC.present(popUpVC, animated: true, completion: nil)
            } else {
                print("error")
            }
        }
    }
}

extension MyWritingViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sideLength = (SizeConstants.screenWidth - 47) / 2
        let cellSize = CGSize(width: sideLength, height: sideLength)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        15.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 210, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: SizeConstants.screenWidth, height: 72 * SizeConstants.screenRatio)
    }
}
