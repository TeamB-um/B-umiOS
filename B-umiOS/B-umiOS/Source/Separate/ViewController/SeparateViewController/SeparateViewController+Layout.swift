//
//  SeparateViewController+layout.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/06.
//

import UIKit

extension SeparateViewController {
    func setConstraints() {
        view.addSubviews([navigationView, separateCollectionView])

        navigationView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(SizeConstants.navigationHeight)
        }

        separateCollectionView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
