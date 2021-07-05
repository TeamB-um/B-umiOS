//
//  UILabel+Extension.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/03.
//

import UIKit

extension UILabel {
    /// 행간을 조정하는 함수
    func lineSpacing(spacing: CGFloat) {
        if let text = self.text {
            let attributeString = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()

            style.lineSpacing = spacing

            attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0, attributeString.length))
            self.attributedText = attributeString
        }
    }
}
