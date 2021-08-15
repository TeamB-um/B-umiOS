//
//  WritingColor.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/04.
//

import UIKit

enum WritingStyle: Int {
    case paper1 = 1
    case paper2 = 2
    case paper3 = 3
    case paper4 = 4
}

extension WritingStyle {
    var placeholderColor: UIColor {
        switch self {
        case .paper1, .paper3, .paper4:
            return .textGray
        case .paper2:
            return .iconGray
        }
    }

    var textColor: UIColor {
        switch self {
        case .paper1, .paper2:
            return .header
        case .paper3, .paper4:
            return .background
        }
    }

    var dividerColor: UIColor {
        switch self {
        case .paper1, .paper3, .paper4:
            return UIColor.textGray
        case .paper2:
            return UIColor.iconGray
        }
    }
}
