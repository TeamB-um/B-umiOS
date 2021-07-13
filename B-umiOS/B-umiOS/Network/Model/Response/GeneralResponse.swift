//
//  GeneralResponse.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/13.
//

import Foundation

struct GeneralResponse<T: Codable>: Codable {
    let success: Bool
    let message: String?
    let data: T?
}
