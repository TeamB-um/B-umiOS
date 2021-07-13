//
//  WritingResponse.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/13.
//

import Foundation

struct WritingsResponse: Codable {
    let writings: [Writing]
}

struct WritingResponse: Codable {
    let writing: Writing

    enum CodingKeys: String, CodingKey {
        case writing = "writingresult"
    }
}
