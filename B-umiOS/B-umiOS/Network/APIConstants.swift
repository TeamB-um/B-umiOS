//
//  APIConstants.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/11.
//

import Foundation

struct APIConstants {
    /// API 넣기
    static let baseURL = "http://3.36.92.162:5000"
    static let application_json = "application/json"

    /// user API
    // FIXME: - userURL로 네이밍 변경
    static let userURL = APIConstants.baseURL + "/users"

    /// category API
    static let categoryURL = APIConstants.baseURL + "/categories"

    /// writing API
    static let writingURL = APIConstants.baseURL + "/writings"

    /// trashCan API
    static let trashCanURL = APIConstants.baseURL + "/trashcans"

    /// reward API
    static let rewardURL = APIConstants.baseURL + "/rewards"
}
