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

        return CGSize(width: label.bounds.width + 30, height: label.bounds.height + 20)
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

extension WritingViewController: UICollectionViewDelegate {
    // FIXME: - 일단.. 잠시 사라지게만 해뒀음 좌표값에 따라 변경 필요

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x < 10 {
            UIView.animate(withDuration: 0.3) {
                self.leftGradientView.alpha = 0
                self.righrGradientView.alpha = 1
            }
        } else if scrollView.contentOffset.x > scrollView.contentSize.width - scrollView.bounds.width {
            UIView.animate(withDuration: 0.3) {
                self.leftGradientView.alpha = 1
                self.righrGradientView.alpha = 0
            }
        }
    }
}

// MARK: - UITextViewDelegate

extension WritingViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        setTextView()
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            setTextView()
        }
    }
}

// MARK: -

extension WritingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textView.becomeFirstResponder()

        return true
    }
}
