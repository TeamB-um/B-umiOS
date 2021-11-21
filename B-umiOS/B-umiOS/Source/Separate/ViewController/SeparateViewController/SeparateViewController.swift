//
//  SeparateViewController.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/02.
//

import UIKit

class SeparateViewController: UIViewController {
    // MARK: - UIComponenets
    
    lazy var navigationView = CustomNavigationBar(title: "분리수거", backButtonAction: nil, rightButtonAction: { [weak self] in
        let vc = SeparateGraphPopUpViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        self?.tabBarController?.present(vc, animated: true, completion: nil)
    }, rightButtonIcon: .graph)
    
    let separateCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionHeadersPinToVisibleBounds = true
        
        $0.backgroundColor = .white
        $0.frame = .zero
        $0.collectionViewLayout = layout
        $0.showsVerticalScrollIndicator = false
    }
        
    // MARK: - Properties
    
    var tag: [Category] = []
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setCollectionView()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchCategoriesData()
    }
    
    // MARK: - Actions
    
//    @objc func didTapGraphButton() {}
    
    // MARK: - Methods
    
    func setView() {
        view.backgroundColor = .background
    }
    
    func setCollectionView() {
        separateCollectionView.delegate = self
        separateCollectionView.dataSource = self
        separateCollectionView.backgroundColor = .background
        
        separateCollectionView.register(SeparateCollectionViewCell.self, forCellWithReuseIdentifier: SeparateCollectionViewCell.identifier)
        separateCollectionView.register(SeperateHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SeperateHeaderView.identifier)
        separateCollectionView.register(SeperateFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: SeperateFooterView.identifier)
    }
    
    func setSeperateImage(row: Int, count: Int) -> String {
        "seperate\(row + 1)_\(count)"
    }
    
    func fetchCategoriesData() {
        ActivityIndicator.shared.startLoadingAnimation()
        
        CategoryService.shared.fetchCategories { response in
            ActivityIndicator.shared.stopLoadingAnimation()
            
            guard let result = response as? NetworkResult<Any> else { return }
            
            switch result {
            case .success(let data):
                guard let result = data as? GeneralResponse<CategoriesResponse> else { return }
                self.tag = result.data?.category ?? []
                self.separateCollectionView.reloadData()
            case .requestErr, .pathErr, .serverErr, .networkFail: break
            }
        }
    }
    
    // MARK: - Protocols
}
