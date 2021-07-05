//
//  TrashBinManageViewController.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/04.
//

import UIKit

class SettingTrashBinViewController: UIViewController {

    // MARK: - UIComponenets
    private var headerView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private var headerLabel = UILabel().then {
        $0.text = "휴지통 관리"
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 20)
    }
    
    private var backButton = UIButton().then {
        $0.setImage(UIImage(named: "btnBack"), for: .normal)
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
    
    private var trashbinStatusNumber = UILabel().then {
        $0.text = "5/9"
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 13)
        $0.textColor = .green2Main
    }
    
    private lazy var trashbinTableView = UITableView().then {
        $0.separatorStyle = .none
    }
    
    // MARK: - Properties
    
    var bins = ["a","b","c","d","e"]
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .background
        setConstraint()
        setTableView()
    }
    
    // MARK: - Actions
    
    @objc
        private func didTapAddButton(_ sender: UIButton) {
            
            if let popUpVC = self.storyboard?.instantiateViewController(identifier: "TrashBinPopUpViewController"){
                popUpVC.modalPresentationStyle = .overCurrentContext
                popUpVC.modalTransitionStyle = .crossDissolve
                        
                self.tabBarController?.present(popUpVC, animated: true, completion: nil)
            }
                   
        }
    
    // MARK: - Methods
  
    func setConstraint(){
        let line = UIView().then {
            $0.backgroundColor = UIColor(white: 237.0 / 255.0, alpha: 1.0)
        }
        
        self.view.addSubviews([headerView,line,trashbinStatusLabel,trashbinStatusNumber,trashbinTableView])
        headerView.addSubviews([headerLabel,backButton,addButton])
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(self.view)
            make.width.equalToSuperview()
        }
        
        headerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(57)
            make.bottom.equalToSuperview().inset(13)
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalTo(headerLabel)
        }
        
        addButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(headerLabel)
        }
        
        line.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        trashbinStatusLabel.snp.makeConstraints { make in
            make.top.equalTo(line).offset(16)
            make.leading.equalToSuperview().inset(24)
        }
        
        trashbinStatusNumber.snp.makeConstraints { make in
            make.top.equalTo(trashbinStatusLabel)
            make.trailing.equalToSuperview().inset(28)
        }
        
        trashbinTableView.snp.makeConstraints { make in
            make.top.equalTo(trashbinStatusLabel.snp.bottom).offset(12)
            make.trailing.leading.bottom.equalToSuperview()
        }
    }
    
    func setTableView(){
        trashbinTableView.delegate = self
        trashbinTableView.dataSource = self
        
        trashbinTableView.register(UINib(nibName: "TrashBinTableViewCell", bundle: nil), forCellReuseIdentifier: "TrashBinTableViewCell")
    }
    
    // MARK: - Protocols
}

// MARK: - Protocols

extension SettingTrashBinViewController: UITableViewDelegate{
    
}

extension SettingTrashBinViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrashBinTableViewCell", for: indexPath) as! TrashBinTableViewCell
        
        cell.trashbinName.text = bins[indexPath.row]
        return cell
    }
    
    
}
