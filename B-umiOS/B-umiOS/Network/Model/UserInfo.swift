//
//  UserInfo.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/13.
//

import Foundation

struct UserInfo: Codable {
    let isPush: Bool?
    let deletePeriod: Int?

    enum CodingKeys: String, CodingKey {
        case isPush = "ispush"
        case deletePeriod = "delperiod"
    }
}
