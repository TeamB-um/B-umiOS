//
//  Category.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/13.
//

import Foundation

struct Category: Codable {
    let id, name: String
    let index, count: Int?
    let img: String
    let createdDate: String
    let userID: String? /// 서버가 안 고쳐줌

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case index, count, img
        case createdDate = "created_date"
        case userID = "user_id"
    }
}
