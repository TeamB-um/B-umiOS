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
    }
    
    func stringToDate(format: String = "yyyy-MM-dd", date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .init(identifier: "ko_KR")
        dateFormatter.dateFormat = format
        
        return dateFormatter.date(from: date) ?? Date()
    }
    
    func ISOStringToDate(date: String) -> Date {
        
        let iso8601DateFormatter = ISO8601DateFormatter()
        iso8601DateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let dateFormatter = DateFormatter()
        
        let date = iso8601DateFormatter.date(from: date)
        dateFormatter.locale = .init(identifier: "ko_KR")
        
        return date ?? Date()
    }
    
    func ISODateToString(format: String = "yyyy.MM.dd(E)", date: Date) -> String {
        let iso8601DateFormatter = ISO8601DateFormatter()
        iso8601DateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .init(identifier: "ko_KR")
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(for: date) ?? ""
    }
}
