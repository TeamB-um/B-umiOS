//
//  SeparateToastViewController.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/08/17.
//

import UIKit

class SeparateToastViewController: UIViewController {
    // MARK: - UIComponenets
    let toastLabel = UILabel().then {
        $0.text = "아직 덜 찬 휴지통이에요"
        $0.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.cornerRound(radius: 22)
        $0.font = UIFont.nanumSquareFont(type: .regular, size: 14)
        
    }
    
    
    // MARK: - Properties
    
  
    // MARK: - Initializer
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        selfDismiss()
        setConstraints()
    }
    
    // MARK: - Actions
    
    // MARK: - Methods
    
    func selfDismiss(){
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func setConstraints() {
        view.addSubviews([toastLabel])
        
        toastLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(116 * SizeConstants.screenWidthRatio)
            make.width.equalTo(182 * SizeConstants.screenWidthRatio)
            make.height.equalTo(toastLabel.snp.width).multipliedBy(45.0 / 182.0)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Protocols
}
