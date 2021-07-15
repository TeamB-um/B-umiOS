//
//  SeparateDetailViewController+Extension.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/08.
//

import UIKit

// MARK: - UITableViewDelegate

extension SeparateDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        72 * SizeConstants.screenRatio
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        bottomView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(!self.confirmButton.isHidden){
            tableView.cellForRow(at: indexPath)?.isSelected = true
            removeData.append(indexPath.row)
            isActivated()
        }
        else{
            let writing = writings[indexPath.row]
            let createdDate = Date().stringToDate(date: writings[indexPath.row].createdDate)
            let vc = MyWritingPopUpViewController(writing: DummyWriting(trashBin: writing.category.name, title: writing.title, date: createdDate, content: writing.text))
            
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
                                                      
            self.tabBarController?.present(vc, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if(!self.confirmButton.isHidden){
            tableView.cellForRow(at: indexPath)?.isSelected = false
            guard let elementIndex = removeData.firstIndex(of: indexPath.row) else { return }
            print(elementIndex)
            removeData.remove(at: elementIndex)
            isActivated()
        }
    }
}

// MARK: - UITableViewDataSource

extension SeparateDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        writings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SeparateDetailTableViewCell.identifier, for: indexPath) as? SeparateDetailTableViewCell else {
            return UITableViewCell()
        }
        cell.checkButton.isHidden = !self.removeButton.isSelected
        
        let writing = writings[indexPath.row]
        cell.setData(title: writing.title, contents: writing.text)
        
        return cell
    }
}

extension SeparateDetailViewController: DeleteDelegate{
    func sendWritings(_ newWritings : [Writing]) {
        removeData = []
        isActivated()
        writings = newWritings
        self.removeButton.setupRoundingButton(title: "삭제", image: "btnRemove")
        self.confirmButton.isHidden = true
        self.removeButton.isSelected = false
        self.detailTableView.reloadData()
    }
}
