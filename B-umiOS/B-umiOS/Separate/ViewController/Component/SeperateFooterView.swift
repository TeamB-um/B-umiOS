//
//  SeperateFooterView.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/12.
//

import Foundation
import UIKit

class SeperateFooterView: UICollectionReusableView {
    // MARK: - Properties
    
    // MARK: - Initializer
    static let identifier = "SeperateFooterView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .background
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
}
