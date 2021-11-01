//
//  GraphResponse.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/16.
//

import Foundation

struct GraphResponse: Codable {
    let allstat: [GraphComponent]
    let monthstat: [GraphComponent]
}

struct GraphComponent: Codable {
    let name: String
    let index: Int
    let percent: Int
}
