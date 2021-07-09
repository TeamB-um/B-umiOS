//
//  SeparateDetailViewController+Extension.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/08.
//

import UIKit

// MARK: - UITableViewDelegate

extension SeparateDetailViewController: UITableViewDelegate {
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
        cell.checkButton.isHidden = !self.checkButton.isSelected
    
        return cell
    }
}
