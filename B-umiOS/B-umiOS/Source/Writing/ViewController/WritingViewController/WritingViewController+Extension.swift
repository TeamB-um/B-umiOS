//
//  WritingViewController+Extension.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/05.
//

import UIKit

// MARK: - UICollectionViewDelegateFlowLayout

extension WritingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        label.text = tag[indexPath.row].name
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

        cell.setTagLabel(tag: tag[indexPath.row].name)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tagSelectedIdx = indexPath.item
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

extension WritingViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
        let scrollViewWidth = scrollView.bounds.size.width
        let maxOffset = scrollView.contentSize.width - 2
        let minOffset = offset - 2

        if minOffset < 0 {
            UIView.animate(withDuration: 0.3) {
                self.leftGradientView.alpha = 0
                self.righrGradientView.alpha = 1
            }
        } else if offset + scrollViewWidth < maxOffset {
            UIView.animate(withDuration: 0.3) {
                self.leftGradientView.alpha = 1
                self.righrGradientView.alpha = 1
            }
        } else {
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

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentCharacterCount = textView.text?.count ?? 0
        let newLength = currentCharacterCount + text.count - range.length

        if newLength > 0 {
            checkButton.isUserInteractionEnabled = true
            checkButton.tintColor = .header
        } else {
            checkButton.isUserInteractionEnabled = false
            checkButton.tintColor = .disable
        }

        return true
    }
}

// MARK: - UITextFieldDelegate

extension WritingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.textView.becomeFirstResponder()

        return true
    }
}

// MARK: - WritingPopUpDelegate

extension WritingViewController: WritingPopUpDelegate {
    func writingPopUpViewPush(trash: TrashType, writing: WritingRequest) {
        let trashViewController = ThrowTrashViewController(trashType: trash, writingRequest: writing)

        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        self.navigationController?.pushViewController(trashViewController, animated: true)
    }
}
