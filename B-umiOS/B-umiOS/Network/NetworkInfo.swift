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

//    static let token = UserDefaults.standard.string(forKey: UserDefaults.Keys.token) ?? ""
    static let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjBmMTU4Yjc2M2NlZjY1YmI3YTM3ZmE2In0sImlhdCI6MTYyNjQyOTYyNCwiZXhwIjoxNjI2Nzg5NjI0fQ.d8Xq9RKdchbpqEVMmYiZcW8gkl7yJjQrUK2PI3Ovnus"

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
