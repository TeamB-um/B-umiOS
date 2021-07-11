//
//  NetworkInfo.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/11.
//

import Foundation
import Alamofire

enum NetworkHeaderKey: String {
    case auth = "x-auth-token"
    case content_type = "Content-Type"
}

struct NetworkInfo {
    static let shared = NetworkInfo()
    
    static let token = UserDefaults.standard.string(forKey: "token") ?? ""
    
    static var headerOnlyType: HTTPHeaders {
        return [NetworkHeaderKey.content_type.rawValue:  APIConstants.application_json]
    }
    
    static var headerWithToken: HTTPHeaders {
        return [NetworkHeaderKey.content_type.rawValue: APIConstants.application_json, NetworkHeaderKey.auth.rawValue: token]
    }
    
    func makeParameter<T : Codable> (model : T.Type){
        switch model {
        default: break
        }
        //모델에 따라 parameter 만들기
    }
}
