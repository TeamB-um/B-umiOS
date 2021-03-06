//
//  NetworkInfo.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/11.
//

import Alamofire
import Foundation

enum NetworkHeaderKey: String {
    case auth = "x-auth-token"
    case content_type = "Content-Type"
}

struct NetworkInfo {
    static let shared = NetworkInfo()

    static let token = UserDefaults.standard.string(forKey: UserDefaults.Keys.token) ?? ""

    static var headerOnlyType: HTTPHeaders {
        [NetworkHeaderKey.content_type.rawValue: APIConstants.application_json]
    }

    static var headerWithToken: HTTPHeaders {
        [NetworkHeaderKey.content_type.rawValue: APIConstants.application_json, NetworkHeaderKey.auth.rawValue: token]
    }

    /// 모델에 따라 parameter 만들기
    func makeParameter<T: Codable>(model: T) -> [String: Any]? {
        let jsonEncoder = JSONEncoder()
        guard let jsonData = try? jsonEncoder.encode(model) else { return nil }
        guard let dictionary = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else { return nil }

        return dictionary
    }
}
