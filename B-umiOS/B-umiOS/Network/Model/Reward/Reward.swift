//
//  Reward.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/13.
//

import Foundation

struct Reward: Codable {
    let sentence, author, context: String
    let index: Int
    let createdDate: String?
    var id, user_id: String?

    enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case sentence, author, context, index
        case createdDate = "created_date"
    }
}
