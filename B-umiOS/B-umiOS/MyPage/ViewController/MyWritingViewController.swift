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
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .paper1
        
        collectionView.register(MyWritingCollectionViewCell.self, forCellWithReuseIdentifier: MyWritingCollectionViewCell.identifier)
        
        collectionView.register(ButtonSectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ButtonSectionView.identifier)
        
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
        
        view.addSubview(myWritingCollectionView)
        
        myWritingCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.leading.trailing.equalToSuperview()
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
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
//        let headerView = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonSectionView.identifier, for: indexPath)
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ButtonSectionView.identifier, for: indexPath)
        

        return headerView
    }


}

extension MyWritingViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let sideLength = (width - 47) / 2
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
        let width = UIScreen.main.bounds.width
        
        return CGSize(width: width, height: 72)
    }
}
