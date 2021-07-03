//
//  Date+Extension.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/03.
//

import Foundation

extension Date {
    func dateToString(format: String = "yyyy.MM.dd", date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .init(identifier: "ko_KR")
        dateFormatter.dateFormat = format

        return dateFormatter.string(from: date)
    }}
