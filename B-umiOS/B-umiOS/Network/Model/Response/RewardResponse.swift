//
//  RewardResponse.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/13.
//

import Foundation

struct RewardResponse : Codable{
    let reward: Reward
}

struct RewardsResponse: Codable {
    let rewards: [Reward]
}
