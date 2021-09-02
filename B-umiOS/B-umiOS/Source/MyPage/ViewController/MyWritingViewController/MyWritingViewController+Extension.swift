//
//  MyWritingViewController+Extension.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/08/05.
//

import UIKit

extension MyWritingViewController: ChangeWritingDataDelegate {
    func changeWitingData(filteredDate: [Writing], count: Int) {
        page = 1
        myWriting = filteredDate
        writingCount = count
        myWritingCollectionView.reloadData()
    }
    
    func remainFilterData(filteredCategoryID: String, filteredStartDate: String, filteredEndDate: String) {
        categoryID = filteredCategoryID
        startDate = filteredStartDate
        endDate = filteredEndDate
    }
}

/// 삭제한 후 데이터 변경
extension MyWritingViewController: DeleteDelegate {
    func sendWritings(_ newWritings: [Writing]) {
        removeData = []
        myWriting = newWritings
        NotificationCenter.default.post(name: Notification.Name.confirmButtonIsUnactive, object: nil)
        myWritingCollectionView.reloadData()
    }
}

extension MyWritingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        myWriting.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyWritingCollectionViewCell.identifier, for: indexPath) as? MyWritingCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setShadow(radius: 20, offset: CGSize(width: 0, height: 4), opacity: 0.03)
        cell.setWritingData(data: myWriting, index: indexPath.row)
        cell.checkButton(bool: deleteButtonIsSelected)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ButtonSectionView.identifier, for: indexPath) as? ButtonSectionView else { return UICollectionReusableView() }
        headerView.confirmButtton.addTarget(self, action: #selector(didTapConfirmButton(_:)), for: .touchUpInside)
        headerView.categoryButtton.addTarget(self, action: #selector(didTapCategoryButton(_:)), for: .touchUpInside)
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !deleteButtonIsSelected {
            let popUpVC = MyWritingPopUpViewController(writing: myWriting[indexPath.row])
            popUpVC.modalTransitionStyle = .crossDissolve
            popUpVC.modalPresentationStyle = .overCurrentContext
            if let parentVC = view.superview?.parentViewController {
                parentVC.present(popUpVC, animated: true, completion: nil)
            } else {
                print("error")
            }
        } else {
            removeData.append(indexPath.row)
            if removeData.count >= 1 {
                NotificationCenter.default.post(name: Notification.Name.confirmButtonIsActive, object: nil)
            }
        }
    }
}

extension MyWritingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sideLength = (SizeConstants.screenWidth - 47) / 2
        let cellSize = CGSize(width: sideLength, height: sideLength)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        15.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 16, bottom: 210, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: SizeConstants.screenWidth, height: 72 * SizeConstants.screenRatio)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cellCount = collectionView.indexPathsForSelectedItems?.count
        
        if deleteButtonIsSelected {
            guard let elementIndex = removeData.firstIndex(of: indexPath.row) else { return }
            removeData.remove(at: elementIndex)
            
            if cellCount == 0 {
                NotificationCenter.default.post(name: Notification.Name.confirmButtonIsUnactive, object: nil)
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = max(myWritingCollectionView.contentOffset.y, 0)
        if offset > myWritingCollectionView.contentSize.height - myWritingCollectionView.bounds.size.height
        , fetchingMore, myWriting.count < writingCount {
            fetchingMore = false
            page += 1
            fetchWriting(page: page)
        }
    }
}

extension MyWritingViewController: viewDelegate {
    func backgroundRemove() {
        backgroundView.removeFromSuperview()
    }
}

