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
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 72 * SizeConstants.screenRatio
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return bottomView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 80
    }
}

// MARK: - UITableViewDataSource

extension SeparateDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SeparateDetailTableViewCell.identifier, for: indexPath) as? SeparateDetailTableViewCell else {
            return UITableViewCell()
        }
        cell.checkButton.isHidden = !self.removeButton.isSelected
        
        if(cell.checkButton.isHidden){
            print("click cell")
            
        }
        else{
            cell.selectionStyle = .none
        }
        
        return cell
    }
}
