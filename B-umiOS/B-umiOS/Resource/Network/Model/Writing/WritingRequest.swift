//
//  WritingRequest.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/13.
//

import Foundation

struct WritingRequest: Codable {
    let title: String?
    let text, categoryID: String
    var isWriting: Bool
    let paper: Int

    enum CodingKeys: String, CodingKey {
        case title, text, paper
        case categoryID = "category_id"
        case isWriting = "iswriting"
    }
}
