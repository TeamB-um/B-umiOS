//
//  SeparateDetailViewController.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/07.
//

import UIKit

class SeparateDetailViewController: UIViewController {
    // MARK: - UIComponenets
    let navigationView = UIView().then {
        $0.backgroundColor = .white
    }
    
    let navigationLabel = UILabel().then {
        $0.text = "글쓰기"
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
        $0.textColor = UIColor.header
    }
    
    var backButton = UIButton().then {
        $0.setImage(UIImage(named: "btnBack"), for: .normal)
        $0.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
    }
    
    var removeButton = RoundingButton().then {
        $0.setupRoundingButton(title: "삭제", image: "btnRemove")
        $0.isHidden = true
    }
    
    var checkButton = RoundingButton().then {
        $0.setupRoundingButton(title: "선택", image: "btnCheckUnseleted")
        $0.addTarget(self, action: #selector(didTapCheckButton), for: .touchUpInside)
    }
    
    lazy var navigationDividerView = UIView().then {
        $0.backgroundColor = .paper1
    }
    
    lazy var detailTableView = UITableView().then {
        $0.separatorStyle = .none
    }
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setTableView()
        setConstraint()
    }
    
    // MARK: - Actions
    @objc func didTapBackButton(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapCheckButton(){
        
        if self.checkButton.isSelected {
            self.checkButton.setupRoundingButton(title: "선택", image: "btnCheckUnseleted")
            self.removeButton.isHidden = true
            self.checkButton.isSelected = false
        }
        else{
            self.checkButton.setupRoundingButton(title: "취소", image: "btnDelete")
            self.removeButton.isHidden = false
            self.checkButton.isSelected = true
        }
        
        self.detailTableView.reloadData()
    }
    
    // MARK: - Methods
        
    func setView(){
        view.backgroundColor = .background
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    func setTableView(){
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.register(SeparateDetailTableViewCell.self, forCellReuseIdentifier: SeparateDetailTableViewCell.identifier)
    }
    
    // MARK: - Protocols
}
