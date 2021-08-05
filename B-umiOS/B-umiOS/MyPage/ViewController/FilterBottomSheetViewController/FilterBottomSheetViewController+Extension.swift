//
//  FilterBottomSheetViewController+Extension.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/08/05.
//

import UIKit

extension FilterBottmSheetViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        label.text = tag[indexPath.row].name
        label.font = UIFont.nanumSquareFont(type: .regular, size: 16)
        label.sizeToFit()
        
        return CGSize(width: label.bounds.width + 32, height: label.bounds.height + 18)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
}

// MARK: - UICollectionViewDataSource

extension FilterBottmSheetViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tag.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WritingTagCollectionViewCell.identifier, for: indexPath) as? WritingTagCollectionViewCell else { return UICollectionViewCell() }
        cell.setTagLabel(tag: tag[indexPath.row].name)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        categoryID = tag[indexPath.row].id
        categoryName = tag[indexPath.row].name
    }
}
