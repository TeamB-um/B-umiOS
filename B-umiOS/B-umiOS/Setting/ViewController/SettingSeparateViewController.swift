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
    
    static let identifier = "SettingSeparateViewController"
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .background
        
        setConstraint()
        setTableView()
    }
    
    // MARK: - Actions
    @objc
        private func didTapBackButton(_ sender: UIButton) {
            self.navigationController?.popViewController(animated: true)
        }
    
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
        let navigationHeight = 56 + UIDevice.current.safeAreaInset.top
        
        self.view.addSubviews([navigationView, navigationDividerView, trashbinStatusLabel, trashbinStatusNumber, trashbinTableView])
        navigationView.addSubviews([headerLabel,backButton,addButton])
        
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
}

// MARK: - Protocols

extension SettingSeparateViewController: UITableViewDelegate{
    
}

extension SettingSeparateViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrashBinTableViewCell", for: indexPath) as! TrashBinTableViewCell
        
        cell.trashbinName.text = bins[indexPath.row]
        return cell
    }
}
