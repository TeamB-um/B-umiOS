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
    }
    
    var checkButton = RoundingButton().then {
        $0.setupRoundingButton(title: "선택", image: "btnCheckUnseleted")
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
