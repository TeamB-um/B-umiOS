//
//  WritingViewController+Extension.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/05.
//

import UIKit

// MARK: - UICollectionViewDelegateFlowLayout

var tag: [String] = ["인간관계", "취업", "날파리", "거지챌린지", "아르바이트", "부장님"]

extension WritingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        label.text = tag[indexPath.row]
        label.font = UIFont.nanumSquareFont(type: .regular, size: 16)
        label.sizeToFit()

        return CGSize(width: label.bounds.width + 32, height: label.bounds.height + 18)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        28
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
}

// MARK: - UICollectionViewDataSource

extension WritingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tag.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WritingTagCollectionViewCell.identifier, for: indexPath) as? WritingTagCollectionViewCell else { return UICollectionViewCell() }

        cell.setTagLabel(tag: tag[indexPath.row])
        return cell
    }
}
