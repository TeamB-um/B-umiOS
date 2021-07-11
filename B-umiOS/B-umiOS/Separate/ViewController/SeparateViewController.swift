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
    
    let explanationView = UIView().then {
        $0.backgroundColor = .paper1
        $0.cornerRound(radius: 10)
        $0.setShadow(radius: 13, offset: CGSize(width: 1, height: 4) , opacity: 0.1, color: .black)
    }
    
    let explanationLabel = UILabel().then {
        $0.text = "당신이 보관한 스트레스입니다."
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 14)
        let attributedStr = NSMutableAttributedString(string: "당신이 보관한 스트레스입니다.")

        attributedStr.addAttribute(.foregroundColor, value: UIColor.blue3, range: ("당신이 보관한 스트레스입니다." as NSString).range(of: "스트레스"))

        $0.attributedText = attributedStr
    }
    
    let separateCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
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
        separateCollectionView.register(SeparateCollectionViewCell.self, forCellWithReuseIdentifier: SeparateCollectionViewCell.identifier)
        separateCollectionView.backgroundColor = .background
    }
    
    func setSeperateImage(row : Int, count : Int) -> String{
        return "seperate\(row+1)_\(count)"
    }
    
    // MARK: - Protocols
}
