//
//  SeparateViewController.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/02.
//

import UIKit

class SeparateViewController: UIViewController {
    // MARK: - UIComponenets
    
    let navigationView = UIView().then {
        $0.backgroundColor = .white
    }
    
    let navigationLabel = UILabel().then {
        $0.text = "분리수거"
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
        $0.textColor = UIColor.header
    }
    
    let graphButton = UIButton().then {
        $0.setImage(UIImage(named: "btnGraph"), for: .normal)
        $0.addTarget(SeparateGraphPopUpViewController.identifier, .popup)
    }
    
    let navigationDividerView = UIView().then {
        $0.backgroundColor = .paper1
    }
    
    let separateCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionHeadersPinToVisibleBounds = true
        
        $0.backgroundColor = .white
        $0.frame = .zero
        $0.collectionViewLayout = layout
        $0.showsVerticalScrollIndicator = false
    }
        
    // MARK: - Properties
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setCollectionView()
        setConstraint()
    }
    
    // MARK: - Actions
    
    // MARK: - Methods
    
    func setView() {
        view.backgroundColor = .background
    }
    
    func setCollectionView() {
        separateCollectionView.delegate = self
        separateCollectionView.dataSource = self
        separateCollectionView.backgroundColor = .background
        
        separateCollectionView.register(SeparateCollectionViewCell.self, forCellWithReuseIdentifier: SeparateCollectionViewCell.identifier)
        separateCollectionView.register(SeperateSectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SeperateSectionView.identifier)
    }
    
    func setSeperateImage(row : Int, count : Int) -> String{
        return "seperate\(row+1)_\(count)"
    }
    
    // MARK: - Protocols
}
