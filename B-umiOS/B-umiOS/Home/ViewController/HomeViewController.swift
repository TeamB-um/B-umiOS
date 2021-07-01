//
//  HomeViewController.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/01.
//

import SnapKit
import Then
import UIKit

class HomeViewController: UIViewController {
    // MARK: - UIComponenets
    
    private let label = UILabel().then {
        $0.text = "Home"
        $0.font = UIFont.nanumSquareFont(type: .extraBold, size: 25)
        $0.textColor = UIColor.green2Main
    }
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraint()
    }
    
    // MARK: - Actions
    
    // MARK: - Methods
    
    func setConstraint() {
        view.addSubviews([label])
        
        label.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Protocols
}
