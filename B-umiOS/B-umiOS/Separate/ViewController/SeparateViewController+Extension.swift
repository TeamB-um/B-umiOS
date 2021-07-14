//
//  SeparateViewController+Extension.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/06.
//

import UIKit
import SnapKit

// MARK: - UICollectionViewDelegateFlowLayout

extension SeparateViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 128 * (UIScreen.main.bounds.width / 375), height: 152 * (UIScreen.main.bounds.width / 375))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 44 * (UIScreen.main.bounds.width / 375), bottom: 0, right: 44 * (UIScreen.main.bounds.width / 375))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20 * (UIScreen.main.bounds.width / 375)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 30 * (UIScreen.main.bounds.width / 375)
    }
}

// MARK: - UICollectionViewDataSource

extension SeparateViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(tag.count < 8){
            return tag.count+1
        }
        return tag.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeparateCollectionViewCell.identifier, for: indexPath) as? SeparateCollectionViewCell else {
            return UICollectionViewCell()
        }
         
        if(indexPath.row == tag.count){
            cell.setData(name: "추가하기", index: 0, count: 0)
        }
        
        else{
            let separate = tag[indexPath.row]
            cell.setData(name: separate.name, index: separate.index ?? 0, count: separate.count ?? 0)
        }

        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension SeparateViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        if(indexPath.row == tag.count){
            let storyboard = UIStoryboard.init(name: "Setting", bundle: nil)
            if let nextVC = storyboard.instantiateViewController(identifier: SeparatePopUpViewController.identifier) as? SeparatePopUpViewController{
                nextVC.method = .add
                nextVC.modalPresentationStyle = .overFullScreen
                nextVC.modalTransitionStyle = .crossDissolve
                self.present(nextVC, animated: true, completion: nil)
            }
        }
        else{
            guard let pushVC = self.storyboard?.instantiateViewController(withIdentifier: SeparateDetailViewController.identifier) as? SeparateDetailViewController else{return}
            
            pushVC.categoryID = tag[indexPath.row].id
            
            self.navigationController?.pushViewController(pushVC, animated: true)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SeperateHeaderView.identifier, for: indexPath)
            
            return headerView
        default:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: SeperateFooterView.identifier, for: indexPath)
            
            return footerView
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: SizeConstants.screenWidth, height: 72 * SizeConstants.screenRatio)
     }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        CGSize(width: SizeConstants.screenWidth, height: 100 * SizeConstants.screenRatio)
    }
}
