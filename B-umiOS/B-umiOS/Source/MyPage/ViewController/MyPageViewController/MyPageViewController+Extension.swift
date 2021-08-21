//
//  MyPageViewController+Extension.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/08/05.
//

import UIKit

// MARK: - Extensions

extension MyPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == myPageMenuCollectionView {
            return 26
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == myPageMenuCollectionView {
            return UIEdgeInsets(top: 0, left: myPageMenuCellLineSpacing, bottom: 0, right: 0)
        }
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = calcLabelSize(text: menu[indexPath.row])

        if collectionView == myPageMenuCollectionView {
            return CGSize(width: size.width + 10, height: size.height + 26)
        }
        let height = UIScreen.main.bounds.height - (size.height + 26 + 3 + view.safeAreaInsets.top)
        return CGSize(width: UIScreen.main.bounds.width, height: floor(height))
    }
}

extension MyPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == menuSectionCollectionView {
            return menu.count
        }
        return subViewControllers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case myPageMenuCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPageMenuCollectionViewCell.identifier, for: indexPath) as? MyPageMenuCollectionViewCell else { return UICollectionViewCell() }

            if indexPath.row == 0 {
                cell.isSelected = true
            } else {
                cell.isSelected = false
            }

            cell.setCell(menu: menu[indexPath.row])

            return cell

        case menuSectionCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuSectionCollectionViewCell.identifier, for: indexPath) as? MenuSectionCollectionViewCell
            else { return UICollectionViewCell() }
            let sectionVC = subViewControllers[indexPath.row]

            return wrapAndGetCell(viewColtroller: sectionVC, cell: cell)

        default:
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == myPageMenuCollectionView {
            menuSectionCollectionView.isPagingEnabled = false
            menuSectionCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
            menuSectionCollectionView.isPagingEnabled = true

            guard let cell = myPageMenuCollectionView.cellForItem(at: indexPath) as? MyPageMenuCollectionViewCell else {
                return
            }

            indicatorBarView.snp.remakeConstraints { make in
                make.top.equalTo(cell.snp.bottom)
                make.leading.equalTo(cell.snp.leading)
                make.width.equalTo(cell.snp.width)
                make.height.equalTo(3)
            }

            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
}

extension MyPageViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x > 375 {}
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let idx = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
        scrollToMenu(to: idx)
        menuSectionCollectionView.reloadData()
    }
}
