//
//  UserRequest.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/13.
//

import Foundation

struct UserRequest: Codable {
    let deviceID: String

    enum CodingKeys: String, CodingKey {
        case deviceID = "device_id"
    }
}
