//
//  MyPageViewController+Layout.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/08/05.
//

extension MyPageViewController {
    func setConstraints() {
        view.addSubviews([myPageMenuCollectionView, indicatorBarView, menuSectionCollectionView])

        let labelSize = calcLabelSize(text: menu[0])

        myPageMenuCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(labelSize.height + 26)
        }

        indicatorBarView.snp.makeConstraints { make in
            make.top.equalTo(myPageMenuCollectionView.snp.bottom)
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(myPageMenuCellLineSpacing)
            make.width.equalTo(labelSize.width + 10)
            make.height.equalTo(3)
        }

        menuSectionCollectionView.snp.makeConstraints { make in
            make.top.equalTo(indicatorBarView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
