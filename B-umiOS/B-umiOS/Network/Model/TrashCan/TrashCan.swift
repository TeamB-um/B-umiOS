//
//  TrashCan.swift
//  B-umiOS
//
//  Created by kong on 2021/07/15.
//

import Foundation

struct TrashCan: Codable {
    let id, title, text: String
    let category: Category
    let dDay: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title, text, category
        case dDay = "d_day"
    }
}
