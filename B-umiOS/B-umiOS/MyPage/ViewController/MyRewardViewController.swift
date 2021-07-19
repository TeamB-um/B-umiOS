//
//  MyRewardViewController.swift
//  B-umiOS
//
//  Created by kong on 2021/07/04.
//

import UIKit

class MyRewardViewController: UIViewController {
    // MARK: - UIComponenets
    
    private lazy var myRewardCollectionView : UICollectionView = {
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
        RewardService.shared.fatchRewardsData { result in
            ActivityIndicator.shared.stopLoadingAnimation()
            guard let rewards = result as? NetworkResult<Any> else { return }
            switch rewards {
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
    
    func setConstraints(){
        view.addSubviews([myRewardCollectionView, errorView, errorLabel])
        myRewardCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.leading.trailing.equalToSuperview()
        }
        errorView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(243 * SizeConstants.screenRatio)
            make.centerX.equalToSuperview()
        }
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(errorView.snp.bottom).inset(10)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Protocols
}
// MARK: - Extension

extension MyRewardViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myReward.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyRewardCollectionViewCell.identifier, for: indexPath) as? MyRewardCollectionViewCell else { return UICollectionViewCell() }
        cell.setData(data: myReward, index: indexPath.row)
        return cell
    }
}

extension MyRewardViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let sideLength = (width - 50) / 2
        let cellSize = CGSize(width: sideLength, height: 232)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        18.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 210, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let popUpVC =  MyRewardPopUpViewController(reward: myReward[indexPath.row])
        popUpVC.modalTransitionStyle = .crossDissolve
        popUpVC.modalPresentationStyle = .overCurrentContext
        
        if let parentVC = view.superview?.parentViewController {
            parentVC.present(popUpVC, animated: true, completion: nil)
        } else {
            print("error")
        }
    }
}
