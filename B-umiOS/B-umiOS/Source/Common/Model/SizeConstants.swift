//
//  SizeConstants.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/07.
//

import UIKit

struct SizeConstants {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    static let screenWidthRatio = screenWidth / 375.0
    static let screenHeightRatio = screenHeight / 812.0
    static let navigationHeight = (57.0 * screenHeightRatio) + UIDevice.current.safeAreaInset.top
}
