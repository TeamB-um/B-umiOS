//
//  UIFont+Extension.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/01.
//

import UIKit

extension UIFont {
    class func nanumSquareFont(type: NanumSquareType, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: type.name, size: size) else { return UIFont() }

        return font
    }
}

enum NanumSquareType: String {
    case light = "L"
    case regular = "R"
    case bold = "B"
    case extraBold = "EB"

    var name: String {
        "NanumSquareOTF_ac" + self.rawValue
    }
}
