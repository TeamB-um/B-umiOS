//
//  MyWritingViewController.swift
//  B-umiOS
//
//  Created by kong on 2021/07/04.
//

import UIKit

class MyWritingViewController: UIViewController {
    // MARK: - UIComponenets
    
    private let filterButton : UIButton = {
        let button = UIButton()

        //라벨 추가하지 않고 buttonTitleLabel로 수정하기! 어 근데. 아이콘은 어저지 ㅋㅋ 아오 큼큼
//        label.text = "전체 카테고리"
//        label.font = .nanumSquareFont(type: .regular, size: 14)
//ㄴㅋ
//        label.snp.makeConstraints{ make in
//            make.top.equalTo(button.snp.center)
//        }
        
        button.backgroundColor = .white
        //모서리 굴곡률
        button.layer.cornerRadius = 16
        //테두리 굵기
        button.layer.borderWidth = 1
        //테두리 색상
        button.layer.borderColor = UIColor.disable.cgColor
        
        return button
    }()
    
    private let selectButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        
        return button
    }()
    
    private let closeButton : UIButton = {
       let button = UIButton()
        button.backgroundColor = .yellow
        
        return button
    }()
    
    private let deleteButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        
        return button
    }()
    
    private lazy var myWritingCollectionView : UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .paper1
        
        collectionView.register(MyWritingCollectionViewCell.self, forCellWithReuseIdentifier: MyWritingCollectionViewCell.identifier)
        
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
        view.addSubviews([myWritingCollectionView, filterButton, selectButton, closeButton, deleteButton])
        
        filterButton.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.width.equalTo(137)
            make.height.equalTo(32)
        }
        
        myWritingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(filterButton.snp.bottom)
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
        return UIEdgeInsets(top: 20, left: 16, bottom: 116, right: 16)
    }
}
