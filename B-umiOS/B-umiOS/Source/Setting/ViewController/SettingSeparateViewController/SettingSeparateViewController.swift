//
//  TrashBinManageViewController.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/04.
//

import UIKit

class SettingSeparateViewController: UIViewController {
    // MARK: - UIComponenets
    
    lazy var navigationView = CustomNavigationBar(title: "분리수거함 관리", backButtonAction: { [weak self] in
        self?.navigationController?.popViewController(animated: true)
    }, rightButtonAction: nil, rightButtonIcon: .none)
    
    var addButton = UIButton().then {
        $0.setImage(UIImage.btnPlus, for: .normal)
        $0.addTarget(self, action: #selector(didTapAddButton(_:)), for: .touchUpInside)
    }
    
    var trashbinStatusLabel = UILabel().then {
        $0.text = "클릭하면 휴지통 이름 수정이 가능해요"
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 13)
        $0.textColor = .green2Main
    }
    
    lazy var trashbinStatusNumber = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 13)
        $0.textColor = .green2Main
    }
    
    lazy var separateTableView = UITableView().then {
        $0.separatorStyle = .none
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 150, right: 0)
    }
    
    // MARK: - Properties
    
    static let identifier = "SettingSeparateViewController"
    
    var bins: [Category] = [] {
        didSet {
            trashbinStatusNumber.text = "\(bins.count)/8"
            
            if bins.count >= 8 {
                addButton.isEnabled = false
            } else {
                addButton.isEnabled = true
            }
        }
    }
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setConstraints()
        setTableView()
        fetchCategories()
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func didTapAddButton(_ sender: UIButton) {
        let nextVC = SeparatePopUpViewController(method: .add)
    
        nextVC.delegate = self
        nextVC.modalPresentationStyle = .overFullScreen
        nextVC.modalTransitionStyle = .crossDissolve
        
        present(nextVC, animated: true, completion: nil)
    }
    
    // MARK: - Methods
  
    func setView() {
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        view.backgroundColor = .background
    }
    
    // MARK: - Network
    
    func fetchCategories() {
        ActivityIndicator.shared.startLoadingAnimation()
        
        CategoryService.shared.fetchCategories { response in
            ActivityIndicator.shared.stopLoadingAnimation()
            
            guard let result = response as? NetworkResult<Any> else { return }
            
            switch result {
            case .success(let data):
                guard let result = data as? GeneralResponse<CategoriesResponse> else { return }
                    
                self.bins = result.data?.category ?? []
                self.separateTableView.reloadData()
                
            case .requestErr, .pathErr, .serverErr, .networkFail:
                /// 네트워크 에러 처리
                print("error")
            }
        }
    }
}

// MARK: - Protocols
