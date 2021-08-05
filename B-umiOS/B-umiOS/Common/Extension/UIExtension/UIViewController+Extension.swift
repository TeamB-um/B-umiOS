//
//  UIViewController+Extension.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/06.
//

import UIKit

extension UIViewController{
    func presentVC(_ gesture : TapGesture) {
        if let nextVC = storyboard?.instantiateViewController(identifier: "\(gesture.nextIdentifier)") {
            switch gesture.method{
            case .popup:
                nextVC.modalPresentationStyle = .overFullScreen
                nextVC.modalTransitionStyle = .crossDissolve
                self.present(nextVC, animated: true, completion: nil)
            case .push:
                self.navigationController?.pushViewController(nextVC, animated: true)
            case .none:
                break
            }
        }
    }
}

