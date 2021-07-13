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
    
    lazy var navigationDividerView = UIView().then {
        $0.backgroundColor = .paper1
    }
    
    var headerView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    var bottomView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    lazy var confirmButton = RoundingButton().then {
        $0.setupRoundingButton(title: "확인", image: "btnCheckUnseleted")
        $0.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
        $0.isHidden = true
    }
    
    var removeButton = RoundingButton().then {
        $0.setupRoundingButton(title: "삭제", image: "btnRemove")
        $0.addTarget(self, action: #selector(didTapCheckButton), for: .touchUpInside)
    }
    
    let gardientBackground = UIImageView().then {
        $0.image = UIImage(named: "mywritingTrashbinBgGradientTop")
    }
    
    lazy var detailTableView = UITableView().then {
        $0.separatorStyle = .none
        $0.backgroundColor = .background
    }
    
    // MARK: - Properties
    var removeData : [Int] = []
    
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
    
    @objc func didTapConfirmButton(){
        if(self.confirmButton.backgroundColor == UIColor.blue2Main){
            let vc = DeletePopUpViewController(title: "글 삭제", guide: "글을 삭제하시겠습니까?")
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
            
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @objc func didTapCheckButton(){
        
        if self.removeButton.isSelected {
            self.removeButton.setupRoundingButton(title: "삭제", image: "btnRemove")
            self.confirmButton.isHidden = true
            self.removeButton.isSelected = false
        }
        
        else{
            self.removeButton.setupRoundingButton(title: "취소", image: "btnCancel")
            self.confirmButton.isHidden = false
            self.removeButton.isSelected = true
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
        detailTableView.allowsMultipleSelection = true
        detailTableView.register(SeparateDetailTableViewCell.self, forCellReuseIdentifier: SeparateDetailTableViewCell.identifier)
    }
    
    func isActivated(){
        if(removeData.isEmpty){
            confirmButton.isActivated(false)
        }
        else{
            confirmButton.isActivated(true)
        }
    }
    
    // MARK: - Protocols
}
