//
//  LoginService.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/11.
//

import Foundation
import Alamofire

struct LoginService {
    static let shared = LoginService()
    
    func login(completion : @escaping(NetworkResult<Any>) -> Void ){
        
//        let url = "http://ec2-3-36-132-39.ap-northeast-2.compute.amazonaws.com/user/ranking"
//
//        RequestHandler.shared.requestData(url: url, httpmethod: .get, parameter: nil, header: NetworkInfo.headerWithToken, decodeType: rankin.self) { completionData in
//        completion(completionData)
//        }
    }
}
