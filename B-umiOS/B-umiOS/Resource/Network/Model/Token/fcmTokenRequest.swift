//
//  fcmTokenRequest.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/08/29.
//

import Foundation

struct fcmTokenRequest: Codable {
    let pushToken: String

    enum CodingKeys: String, CodingKey {
        case pushToken = "pushtoken"
    }
}
