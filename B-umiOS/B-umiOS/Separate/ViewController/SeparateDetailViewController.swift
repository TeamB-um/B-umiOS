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

    static let identifier = "SeparateDetailViewController"
    var removeData: [Int] = []
    var writings: [Writing] = []
    var categoryID: String?
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setTableView()
        setConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchWritings()
    }
    
    // MARK: - Actions
    
    @objc func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapConfirmButton() {
        if !removeData.isEmpty {
            let vc = DeletePopUpViewController(kind: .writing)
            var deleteID: [String] = []

            for index in removeData {
                deleteID.append(writings[index].id)
            }
            
            vc.deleteData = deleteID
            vc.parentDelegate = self
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
            
            tabBarController?.present(vc, animated: true, completion: nil)
        }
    }
    
    @objc func didTapCheckButton() {
        if removeButton.isSelected {
            removeButton.setupRoundingButton(title: "삭제", image: "btnRemove")
            confirmButton.isHidden = true
            removeButton.isSelected = false
        }
        
        else {
            removeButton.setupRoundingButton(title: "취소", image: "btnCancel")
            confirmButton.isHidden = false
            removeButton.isSelected = true
        }
        
        detailTableView.reloadData()
    }
    
    // MARK: - Methods
    
    func fetchWritings() {
        ActivityIndicator.shared.startLoadingAnimation()
        CategoryService.shared.fetchWritings(categories: categoryID!) { result in
            ActivityIndicator.shared.stopLoadingAnimation()
            guard let r = result as? NetworkResult<Any> else { return }
      
            switch r {
            case .success(let response):
                guard let w = response as? GeneralResponse<WritingsResponse> else { return }
                self.writings = w.data?.writing ?? []
                self.detailTableView.reloadData()
            default:
                break
            }
        }
    }
    
    func setView() {
        view.backgroundColor = .background
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    func setTableView() {
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.allowsMultipleSelection = true
        detailTableView.register(SeparateDetailTableViewCell.self, forCellReuseIdentifier: SeparateDetailTableViewCell.identifier)
    }
    
    func isActivated() {
        if removeData.isEmpty {
            confirmButton.isActivated(false)
        }
        else {
            confirmButton.isActivated(true)
        }
    }
    
    // MARK: - Protocols
}

protocol DeleteDelegate {
    func sendWritings(_ newWritings: [Writing])
}
