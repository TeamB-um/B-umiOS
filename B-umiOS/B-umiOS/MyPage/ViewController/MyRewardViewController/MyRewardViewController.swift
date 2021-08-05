//
//  MyRewardViewController.swift
//  B-umiOS
//
//  Created by kong on 2021/07/04.
//

import UIKit

class MyRewardViewController: UIViewController {
    // MARK: - UIComponenets
    
    lazy var myRewardCollectionView : UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .background
        collectionView.register(MyRewardCollectionViewCell.self, forCellWithReuseIdentifier: MyRewardCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    var errorView = UIImageView().then {
        $0.image = UIImage.group192
        $0.isHidden = true
    }
    
    var errorLabel = UILabel().then {
        $0.font = .nanumSquareFont(type: .regular, size: 14)
        $0.textColor = .textGray
        $0.text = "error"
        $0.isHidden = true
    }
    
    // MARK: - Properties
    
    var myReward: [Reward] = []
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchRewardsData()
    }
    
    // MARK: - Actions
    
    // MARK: - Methods
    
    func fetchRewardsData() {
        ActivityIndicator.shared.startLoadingAnimation()
        
        RewardService.shared.fetchRewardsData { response in
            ActivityIndicator.shared.stopLoadingAnimation()
            
            guard let result = response as? NetworkResult<Any> else { return }
            
            switch result {
            case .success(let data):
                self.errorView.isHidden = true
                self.errorLabel.isHidden = true
                
                guard let rewardData = data as? GeneralResponse<RewardsResponse> else { return }
                if let d = rewardData.data {
                    self.myReward = d.rewards
                    self.myRewardCollectionView.reloadData()
                }
            case .requestErr(ErrorMessage.notFound):
                print("404 not found")
                self.errorView.isHidden = false
                self.errorLabel.isHidden = false
                self.errorLabel.text = "아직 리워드가 없어요!"
            default:
                print("default error")
                self.errorView.isHidden = false
                self.errorLabel.isHidden = false
                self.errorLabel.text = "리워드를 찾지 못했어요!"
            }
        }
    }
    
    // MARK: - Protocols
}
