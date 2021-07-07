//
//  MenuSectionCollectionViewCell.swift
//  B-umiOS
//
//  Created by kong on 2021/07/04.
//

import UIKit

class MenuSectionCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "MenuSectionCollectionViewCell"
    static let SUBVIEW_TAG: Int = 1000

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func setCell(view: UIViewController) {}

    /// cell을 재사용할 때 호출한다. 기존에 올라와있던 뷰를 삭제함
    override func prepareForReuse() {
        super.prepareForReuse()

        let subViews = self.contentView.subviews
        for subView in subViews {
            if subView.tag == MenuSectionCollectionViewCell.SUBVIEW_TAG {
                subView.removeFromSuperview()
                print("remove")
            }
        }
    }
}
