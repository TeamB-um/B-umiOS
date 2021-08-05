//
//  SettingSeparateViewController+Extension.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/08/05.
//

import UIKit

extension SettingSeparateViewController: UITableViewDelegate {}

extension SettingSeparateViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SeparateTableViewCell.identifier, for: indexPath) as! SeparateTableViewCell
        
        cell.selectionStyle = .none
        cell.trashBin = bins[indexPath.row]
        return cell
    }
}

extension SettingSeparateViewController: ChangeCategoryDataDelegate {
    func changeCategoryData(data: [Category]) {
        bins = data
        separateTableView.reloadData()
    }
}
