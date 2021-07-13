//
//  MyRewardViewController.swift
//  B-umiOS
//
//  Created by kong on 2021/07/04.
//

import UIKit

class MyRewardViewController: UIViewController {
    // MARK: - UIComponenets
    
    private lazy var myRewardCollectionView : UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .background
        collectionView.register(MyRewardCollectionViewCell.self, forCellWithReuseIdentifier: MyRewardCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    // MARK: - Properties
    // MARK: - Initializer
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraint()
    }
    
    // MARK: - Actions
    // MARK: - Methods
    
    func setConstraint(){
        view.addSubview(myRewardCollectionView)
        
        myRewardCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
    // MARK: - Protocols
}
    // MARK: - Extension

extension MyRewardViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 17
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyRewardCollectionViewCell.identifier, for: indexPath) as? MyRewardCollectionViewCell else { return UICollectionViewCell() }
    
        return cell
    }
}

extension MyRewardViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let sideLength = (width - 50) / 2
        let cellSize = CGSize(width: sideLength, height: 232)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        18.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 210, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let popUpVC =  MyRewardPopUpViewController(reward: DummyReward(trashBinIndex: 1, date: Date(timeIntervalSince1970: .init()), titleReward: "버들가쥣쓰는 야카나..다른 재목을 묵는 버들가짓스다.", authorName: "이인애", subReward: "냐옹"))
        
        popUpVC.modalTransitionStyle = .crossDissolve
        popUpVC.modalPresentationStyle = .overCurrentContext
        
        if let parentVc = view.superview?.parentViewController {
            parentVc.present(popUpVC, animated: true, completion: nil)
        } else {
            print("error")
        }
    }
    
}
