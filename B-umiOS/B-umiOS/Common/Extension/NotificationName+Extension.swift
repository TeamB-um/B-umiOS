//
//  NotificationName+Extension.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/07.
//

import Foundation

extension Notification.Name {
    static let TabBarHide = Notification.Name(rawValue: "TabBarHide")
    static let TabBarShow = Notification.Name(rawValue: "TabBarShow")
    static let deleteButtonIsSelected = Notification.Name(rawValue: "isDeleteButtonSelected")
    static let confirmButtonIsActive = Notification.Name(rawValue: "confirmButtonIsActive")
    static let confirmButtonIsUnactive = Notification.Name(rawValue: "confirmButtonIsUnactive")
    static let categoryIsChanged = Notification.Name(rawValue: "categoryIsChanged")
}
