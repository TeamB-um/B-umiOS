//
//  WritingRequest.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/13.
//

import Foundation

struct WritingRequest {
    let title, text, categoryID: String
    /// 분리수거, 삭제함 구분 추가

    enum CodingKeys: String, CodingKey {
        case title, text
        case categoryID = "category_id"
    }
}
