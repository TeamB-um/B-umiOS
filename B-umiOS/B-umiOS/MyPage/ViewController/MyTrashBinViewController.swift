//
//  MyTrashBinViewController.swift
//  B-umiOS
//
//  Created by kong on 2021/07/04.
//

import UIKit

class MyTrashBinViewController: UIViewController {

    // MARK: - UIComponenets
    var settingButton = RoundingButton().then {
        $0.setupRoundingButton(title: "설정", image: "btnCheckUnseleted")
        //$0.addTarget(self, action: #selector(didTapCheckButton), for: .touchUpInside)
    }
    
    lazy var headerView = UIView().then {
        $0.backgroundColor = .background
    }
    
    lazy var detailTableView = UITableView(frame: .zero, style: .grouped).then {
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
    
    @objc func didTapSettingButton(){
        //휴지통 삭제 기간 팝업 뷰를 띄웁니다
        self.detailTableView.reloadData()
    }
    // MARK: - Methods
    
    func setView(){
        view.backgroundColor = .background
    }
    
    func setTableView(){
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.register(MyTrashBinTableViewCell.self, forCellReuseIdentifier: MyTrashBinTableViewCell.identifier)
    }
    
    func setConstraint(){
        view.addSubviews([detailTableView])
        headerView.addSubview(settingButton)

        settingButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16 * SizeConstants.screenRatio)
            make.top.equalToSuperview().offset(16 * SizeConstants.screenRatio)
        }

        detailTableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyTrashBinTableViewCell.identifier, for: indexPath) as? MyTrashBinTableViewCell else {
            return UITableViewCell()
        }
//        cell.checkButton.isHidden = !self.checkButton.isSelected
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        72
    }
}
