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
        $0.setupRoundingButton(title: "설정", image: "settings")
        $0.addTarget(self, action: #selector(didTapSettingButton), for: .touchUpInside)
    }
    
    var headerView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    var headerGardientBackground = UIImageView().then {
        $0.image = UIImage.mywritingTrashbinBgGradientTop
    }
    
    lazy var detailTableView = UITableView().then {
        $0.separatorStyle = .none
        $0.backgroundColor = .background
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 200, right: 0)
    }

    var errorView = UIImageView().then {
        $0.image = UIImage.group192
        $0.isHidden = true
    }
    
    var errorLabel = UILabel().then {
        $0.font = .nanumSquareFont(type: .regular, size: 14)
        $0.textColor = .textGray
        $0.text = "dlkslfhiwalgnlkwrg"
        $0.isHidden = true
    }
      
    let backgroundView = UIView().then {
        $0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        $0.frame = CGRect(origin: .zero, size: CGSize(width: SizeConstants.screenWidth, height: SizeConstants.screenHeight))
    }
    
    var gradientView = UIImageView().then {
        $0.image = UIImage.mywritingTrashbinBgGradientBottom
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
            
            guard let result = response as? NetworkResult<Any> else { return }
            switch result {
            case .success(let data):
                
                self.errorView.isHidden = true
                self.errorLabel.isHidden = true
                
                guard let trashCanData = data as? GeneralResponse<TrashCanResponse> else { return }

                if let d = trashCanData.data {
                    self.myTrashCan = d.trashCan
                    self.detailTableView.reloadData()
                } else {
                    print("success if let error")
                }
            
            case .requestErr(ErrorMessage.notFound):
                print("404 not found")
                self.errorView.isHidden = false
                self.errorLabel.isHidden = false
                self.errorLabel.text = "아직 글을 작성하지 않았어요!"
            default:
                print("default error")
                self.errorView.isHidden = false
                self.errorLabel.isHidden = false
                self.errorLabel.text = "글을 찾지 못했어요!"
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
    
    // MARK: - Protocols
}
