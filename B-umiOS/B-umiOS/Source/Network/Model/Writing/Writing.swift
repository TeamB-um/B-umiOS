//
//  Writing.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/13.
//

import Foundation

struct Writing: Codable {
    let id, title, text: String
    let category: Category
    let createdDate: String
    let categoryID: String?
    let paper: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title, text, category, paper
        case createdDate = "created_date"
        case categoryID = "category_id"
    }
}
