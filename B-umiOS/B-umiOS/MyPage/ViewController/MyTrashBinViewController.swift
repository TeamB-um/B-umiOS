//
//  MyTrashBinViewController.swift
//  B-umiOS
//
//  Created by kong on 2021/07/04.
//

import UIKit

class MyTrashBinViewController: UIViewController {

    // MARK: - UIComponenets
    var removeButton = RoundingButton().then {
        $0.setupRoundingButton(title: "삭제", image: "btnRemove")
        $0.isHidden = true
    }
    
    var checkButton = RoundingButton().then {
        $0.setupRoundingButton(title: "선택", image: "btnCheckUnseleted")
        //$0.addTarget(self, action: #selector(didTapCheckButton), for: .touchUpInside)
    }
    
    lazy var detailTableView = UITableView().then {
        $0.separatorStyle = .none
    }
    // MARK: - Properties
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
    
    // MARK: - Actions
    
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
        detailTableView.register(MyTrashBinTableViewCell.self, forCellReuseIdentifier: MyTrashBinTableViewCell.identifier)
    }
    
    func setConstraint(){
        view.addSubviews([removeButton, checkButton, detailTableView])
        checkButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16 * SizeConstants.ScreenRatio)
            make.top.equalToSuperview().offset(16 * SizeConstants.ScreenRatio)
        }

        removeButton.snp.makeConstraints { make in
            make.trailing.equalTo(checkButton.snp.leading).offset(-8 * SizeConstants.ScreenRatio)
            make.top.equalTo(checkButton)
        }

        detailTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(checkButton.snp.bottom).offset(8 * SizeConstants.ScreenRatio)
            make.bottom.equalToSuperview()
        }
    }
    // MARK: - Protocols
}

// MARK: - UITableViewDelegate

extension MyTrashBinViewController: UITableViewDelegate {
}

// MARK: - UITableViewDataSource

extension MyTrashBinViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SeparateDetailTableViewCell.identifier, for: indexPath) as? SeparateDetailTableViewCell else {
            return UITableViewCell()
        }
        cell.checkButton.isHidden = !self.checkButton.isSelected
    
        return cell
    }
}
