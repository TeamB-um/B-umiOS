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
    var textColor: UIColor {
        switch self {
        case .paper1, .paper2:
            return UIColor.iconGray
        case .paper3, .paper4:
            return UIColor.paper2
        }
    }

    var paperBgColor: UIColor {
        switch self {
        case .paper1:
            return UIColor.paper1
        case .paper2:
            return UIColor.paper2
        case .paper3:
            return UIColor.paper3
        case .paper4:
            return UIColor.paper4
        }
    }

    var dividerColor: UIColor {
        switch self {
        case .paper1, .paper2:
            return UIColor.textGray
        case .paper3:
            return UIColor.paper2
        case .paper4:
            return UIColor.paper3
        }
    }

    var tagBgColor: UIColor {
        UIColor.disable
    }

    var tagTextColor: UIColor {
        UIColor.paper3
    }

    var tagBorderColor: UIColor {
        UIColor.textGray
    }

    var countColor: UIColor {
        switch self {
        case .paper1, .paper2:
            return UIColor.header
        case .paper3, .paper4:
            return UIColor.white
        }
    }

//    var gradientImage: UIImage {
//        switch self {
//        case .paper1, .paper2:
//            return
//        case .paper3, .paper4:
//            return
//    }
}
