//
//  SeparateViewController+Extension.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/06.
//

import UIKit

// MARK: - UICollectionViewDelegateFlowLayout

let trash: [String] = ["aaa","bbb","cccc","dd","eee","fff","g"]

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
        return trash.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeparateCollectionViewCell.identifier, for: indexPath) as? SeparateCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.separateName.text = trash[indexPath.row]
        cell.separateImage.image = UIImage(named: setSeperateImage(row: indexPath.row, count: 0))
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension SeparateViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "SeparateDetailViewController"){
            self.navigationController?.pushViewController(pushVC, animated: true)
        }
    }
}
