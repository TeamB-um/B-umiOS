//
//  Reward.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/13.
//

import Foundation

struct Reward: Codable {
    let id, sentence, author, context: String
    let index: Int
    let createdDate: String?

    /// index, seq 둘 중에 확정 안 남
    /// created_date 넣는건지

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case sentence, author, context, index
        case createdDate = "created_date"
    }
}
