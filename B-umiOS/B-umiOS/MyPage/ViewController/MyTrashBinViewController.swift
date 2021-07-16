//
//  MyTrashBinViewController.swift
//  B-umiOS
//
//  Created by kong on 2021/07/04.
//

import UIKit

class MyTrashBinViewController: UIViewController {
    // MARK: - UIComponenets
    
    private var settingButton = RoundingButton().then {
        $0.setupRoundingButton(title: "설정", image: "settings")
        $0.addTarget(self, action: #selector(didTapSettingButton), for: .touchUpInside)
    }
    
    private var headerView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private var headerGardientBackground = UIImageView().then {
        $0.image = UIImage(named: "mywritingTrashbinBgGradientTop")
    }
    
    lazy var detailTableView = UITableView().then {
        $0.separatorStyle = .none
        $0.backgroundColor = .background
    }
    
    let backgroundView = UIView().then {
        $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        $0.frame = CGRect(origin: .zero, size: CGSize(width: SizeConstants.screenWidth, height: SizeConstants.screenHeight))
    }
    
    // MARK: - Properties
    
    var myTrashCan: [TrashCan] = []
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setTableView()
        setConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchTrashBinData()
    }
    
    // MARK: - Actions
    
    @objc func didTapSettingButton(){
        
        let popUpVC = PeriodPopUpViewController()
        popUpVC.modalPresentationStyle = .overFullScreen
        popUpVC.modalTransitionStyle = .coverVertical
        
        popUpVC.bgDelegate = self
        
        let window = UIApplication.shared.windows.first
        window?.addSubview(self.backgroundView)
        
        if let parentVC = view.superview?.parentViewController {
            parentVC.present(popUpVC, animated: true, completion: nil)
        }
    }
    
    // MARK: - Methods
    func fetchTrashBinData(){
        ActivityIndicator.shared.startLoadingAnimation()
        TrashCanService.shared.fatchTrashCanData { response in
            ActivityIndicator.shared.stopLoadingAnimation()
            guard let r = response as? NetworkResult<Any> else { return }
            switch r {
            case .success(let data):
                guard let trashCanData = data as? GeneralResponse<TrashCanResponse> else { return }

                if let d = trashCanData.data {
                    self.myTrashCan = d.trashCan
                    self.detailTableView.reloadData()
                } else {
                    print("success if let error")
                }
            
            default:
                print("default error")
            }
        }
    }

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
        headerView.addSubviews([headerGardientBackground, settingButton])

        headerGardientBackground.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        settingButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16 * SizeConstants.screenRatio)
            make.centerY.equalToSuperview()
        }

        detailTableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    // MARK: - Protocols
}

// MARK: - UITableViewDelegate

extension MyTrashBinViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        72 * SizeConstants.screenRatio
    }
}

// MARK: - UITableViewDataSource

extension MyTrashBinViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myTrashCan.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyTrashBinTableViewCell.identifier, for: indexPath) as? MyTrashBinTableViewCell else {
            return UITableViewCell()
        }
        cell.setTrashBinData(data: myTrashCan, index: indexPath.row)
        return cell
    }
}

// MARK: - Extension

extension MyTrashBinViewController: viewDelegate {
    func backgroundRemove() {
        print("close")
        backgroundView.removeFromSuperview()
    }
}
