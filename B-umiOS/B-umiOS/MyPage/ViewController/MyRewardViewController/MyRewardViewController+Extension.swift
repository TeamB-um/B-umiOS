//
//  MyRewardViewController+Extension.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/08/05.
//

import UIKit

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
