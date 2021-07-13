//
//  Category.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/13.
//

import Foundation

struct Category: Codable {
    let id, name, userID: String
    let index, count: Int?
    let img: String
    let createdDate: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case userID = "user_id"
        case index, count, img
        case createdDate = "created_date"
    }
}
