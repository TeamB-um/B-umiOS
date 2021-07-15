//
//  LoginService.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/11.
//

import Alamofire
import Foundation

struct LoginService {
    static let shared = LoginService()

    func login(completion: @escaping (Bool) -> Void) {
        guard let uuid = UIDevice.current.identifierForVendor?.uuidString else { return }
        let parameter = NetworkInfo.shared.makeParameter(model: UserRequest(deviceID: uuid))

        RequestHandler.shared.requestData(url: APIConstants.loginURL, httpmethod: HTTPMethod.post, parameter: parameter, header: NetworkInfo.headerOnlyType, decodeType: GeneralResponse<TokenResponse>.self) { response in
            switch response {
            case .success(let data):
                guard let result = data as? GeneralResponse<TokenResponse> else { return }
                UserDefaults.standard.set(result.data?.token, forKey: UserDefaults.Keys.token)
                print(result.data?.token, "🐱 token")

                completion(true)
            case .requestErr, .pathErr, .serverErr, .networkFail:
                completion(false)
            }
        }
    }
}
