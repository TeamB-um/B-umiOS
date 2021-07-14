//
//  TrashCanResponse.swift
//  B-umiOS
//
//  Created by kong on 2021/07/15.
//

import Foundation

struct TrashCanResponse: Codable {
    let trashCan: [TrashCan]
    
    enum CodingKeys: String, CodingKey {
        case trashCan = "trashresult"
    }
}
