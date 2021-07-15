//
//  TrashBinManageViewController.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/04.
//

import UIKit

class SettingSeparateViewController: UIViewController {
    // MARK: - UIComponenets
    
    let navigationView = UIView().then {
        $0.backgroundColor = .white
    }
    
    let navigationDividerView = UIView().then {
        $0.backgroundColor = .paper1
    }
    
    let headerLabel = UILabel().then {
        $0.text = "분리수거함 관리"
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
    }
    
    var backButton = UIButton().then {
        $0.setImage(UIImage(named: "btnBack"), for: .normal)
        $0.addTarget(self, action: #selector(didTapBackButton(_:)), for: .touchUpInside)
    }
    
    private var addButton = UIButton().then {
        $0.setImage(UIImage(named: "btnPlus"), for: .normal)
        $0.addTarget(self, action: #selector(didTapAddButton(_:)), for: .touchUpInside)
    }
    
    private var trashbinStatusLabel = UILabel().then {
        $0.text = "클릭하면 휴지통 이름 수정이 가능해요"
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 13)
        $0.textColor = .green2Main
    }
    
    lazy var trashbinStatusNumber = UILabel().then {
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 13)
        $0.textColor = .green2Main
    }
    
    private lazy var separateTableView = UITableView().then {
        $0.separatorStyle = .none
    }
    
    // MARK: - Properties
    
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

    static let identifier = "SettingSeparateViewController"
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setConstraint()
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
        nextVC.method = .add
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
    
    func setConstraint() {
        let navigationHeight = 56 + UIDevice.current.safeAreaInset.top
        
        view.addSubviews([navigationView, navigationDividerView, trashbinStatusLabel, trashbinStatusNumber, separateTableView])
        navigationView.addSubviews([headerLabel, backButton, addButton])
        
        navigationView.snp.makeConstraints { make in
            make.top.width.equalToSuperview()
            make.height.equalTo(navigationHeight * SizeConstants.screenRatio)
        }
        
        navigationDividerView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(13 * SizeConstants.screenRatio)
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16 * SizeConstants.screenRatio)
            make.centerY.equalTo(headerLabel)
        }
        
        addButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16 * SizeConstants.screenRatio)
            make.centerY.equalTo(headerLabel)
        }
        
        trashbinStatusLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationDividerView.snp.bottom).offset(16 * SizeConstants.screenRatio)
            make.leading.equalToSuperview().inset(24 * SizeConstants.screenRatio)
        }
        
        trashbinStatusNumber.snp.makeConstraints { make in
            make.top.equalTo(trashbinStatusLabel)
            make.trailing.equalToSuperview().inset(28)
        }
        
        separateTableView.snp.makeConstraints { make in
            make.top.equalTo(trashbinStatusLabel.snp.bottom).offset(12)
            make.trailing.leading.bottom.equalToSuperview()
        }
    }
    
    func setTableView() {
        separateTableView.delegate = self
        separateTableView.dataSource = self
        separateTableView.backgroundColor = .background
        separateTableView.register(UINib(nibName: SeparateTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SeparateTableViewCell.identifier)
    }
    
    // MARK: - Network
    
    func fetchCategories() {
        ActivityIndicator.shared.startLoadingAnimation()
        CategoryService.shared.fetchCategories { result in
            ActivityIndicator.shared.stopLoadingAnimation()
            guard let categories = result as? CategoriesResponse else { return }
            
            self.bins = categories.category
            self.separateTableView.reloadData()
        }
    }
}

// MARK: - Protocols

extension SettingSeparateViewController: UITableViewDelegate {}

extension SettingSeparateViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SeparateTableViewCell.identifier, for: indexPath) as! SeparateTableViewCell
        
        cell.selectionStyle = .none
        cell.trashBin = bins[indexPath.row]
        return cell
    }
}

extension SettingSeparateViewController: changeCategoryDataDelegate {
    func changeCategoryData(data: [Category]) {
        bins = data
        separateTableView.reloadData()
    }
}
