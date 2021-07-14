//
//  APIConstants.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/11.
//

import Foundation

struct APIConstants {
    /// API 넣기
    static let baseURL = "http://13.124.69.82:5000"
    static let application_json = "application/json"

    /// user API
    static let login = APIConstants.baseURL + "/users"
    static let rewardURL = APIConstants.baseURL + "/rewards"
    static let loginURL = APIConstants.baseURL + "/users"

    /// category API
    static let categoryURL = APIConstants.baseURL + "/categories"
    
    /// writing API
    static let writingURL = APIConstants.baseURL + "/writings"
    
    ///trashCan API
    static let trashCanURL = APIConstants.baseURL + "/trashcans"
}
