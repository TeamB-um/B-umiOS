//
//  UIDevice+Extension.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/01.
//

import UIKit

extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }

    var safeAreaInset: UIEdgeInsets {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.windows[0].safeAreaInsets
        } else {
            return UIApplication.shared.keyWindow?.safeAreaInsets ?? UIEdgeInsets.zero
        }
    }
}
