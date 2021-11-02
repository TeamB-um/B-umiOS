//
//  RewardService.swift
//  B-umiOS
//
//  Created by kong on 2021/07/14.
//

import Alamofire
import Foundation

struct RewardService {
    static let shared = RewardService()
    
    func fetchRewardsData(completion: @escaping (Any) -> Void) {
        RequestHandler.shared.requestData(url: APIConstants.rewardURL, httpmethod: HTTPMethod.get, parameter: nil, header: NetworkInfo.headerWithToken, decodeType: GeneralResponse<RewardsResponse>.self) { response in
            completion(response)
        }
    }
}
