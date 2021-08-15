//
//  UIColor_Extension.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/01.
//

import UIKit

extension UIColor {
    convenience init(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) {
        self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }

    @nonobjc class var symbol: UIColor { .init(87, 255, 243, 1) }

    // MARK: - StatusBar

    @nonobjc class var statusBarIcon: UIColor { .init(151, 151, 151, 1) }
    @nonobjc class var statusBar: UIColor { .init(104, 199, 228, 1) }
    @nonobjc class var statusBar2: UIColor { .init(white: 214.0 / 255.0, alpha: 1) }

    // MARK: - Component

    @nonobjc class var header: UIColor { .init(white: 37.0 / 255.0, alpha: 1.0) }
    @nonobjc class var textGray: UIColor { .init(white: 194.0 / 255.0, alpha: 1.0) }
    @nonobjc class var iconGray: UIColor { .init(white: 161.0 / 255.0, alpha: 1.0) }
    @nonobjc class var background: UIColor { .init(white: 250.0 / 255.0, alpha: 1.0) }

    // MARK: - State

    @nonobjc class var error: UIColor { .init(255, 83, 83, 1) }
    @nonobjc class var disable: UIColor { .init(white: 225.0 / 255.0, alpha: 1.0) }

    // MARK: - Blue

    @nonobjc class var blue0: UIColor { .init(223, 247, 255, 1) }
    @nonobjc class var blue2Main: UIColor { .init(110, 213, 245, 1) }
    @nonobjc class var blue3: UIColor { .init(0, 171, 241, 1) }
    @nonobjc class var blue4: UIColor { .init(0, 121, 189, 1) }

    // MARK: - Green

    @nonobjc class var green1: UIColor { .init(82, 190, 134, 1) }
    @nonobjc class var green2Main: UIColor { .init(82, 190, 134, 1) }
    @nonobjc class var green3: UIColor { .init(37, 163, 103, 1) }
    @nonobjc class var green4: UIColor { .init(9, 96, 56, 1) }

    // MARK: - Pink

    @nonobjc class var pink2Main: UIColor { .init(255, 147, 197, 1) }
    @nonobjc class var pink3: UIColor { .init(234, 77, 147, 1) }
    @nonobjc class var pink4: UIColor { .init(199, 42, 117, 1) }

    // MARK: - Paper

    @nonobjc class var paper1: UIColor { .init(white: 241.0 / 255.0, alpha: 1.0) }
    @nonobjc class var paper2: UIColor { .init(white: 202.0 / 255.0, alpha: 1.0) }
    @nonobjc class var paper3: UIColor { .init(white: 131.0 / 255.0, alpha: 1.0) }
    @nonobjc class var paper4: UIColor { .init(white: 71.0 / 255.0, alpha: 1.0) }
}
