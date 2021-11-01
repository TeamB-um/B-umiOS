//
//  UIView+Extension.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/01.
//

import UIKit

enum ShowMethod {
    case push
    case popup
}

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
    
    func cornerRounds() {
        self.layer.cornerRadius = self.layer.frame.height / 2
        self.layer.masksToBounds = true
    }
    
    func cornerRound(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func setShadow(radius: CGFloat, offset: CGSize, opacity: Float, color: UIColor = .black) {
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    func addTarget(_ identifier : String, _ method : ShowMethod) {
        let tapGesture = TapGesture(target: self, action: #selector(touchInside(_:)))
        tapGesture.nextIdentifier = identifier
        tapGesture.method = method
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
    }
    
    @objc func touchInside(_ gesture : TapGesture) {
        parentViewController?.presentVC(gesture)
    }
}

