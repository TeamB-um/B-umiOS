//
//  APIConstants.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/11.
//

import Foundation

struct APIConstants {
    /// API 넣기
    static let baseURL = "http://3.36.108.3:5000"
    static let application_json = "application/json"

    /// user API
    static let userURL = APIConstants.baseURL + "/users"
    static let fcmTokenURL = APIConstants.baseURL + "/pushtokens"

    /// category API
    static let categoryURL = APIConstants.baseURL + "/categories"
    static let categoryGraphURL = APIConstants.writingURL + "/stat/graph"

    /// writing API
    static let writingURL = APIConstants.baseURL + "/writings"

    /// reward API
    static let rewardURL = APIConstants.baseURL + "/rewards"

    /// present API
    static let presentURL = APIConstants.baseURL + "/presents"
}
