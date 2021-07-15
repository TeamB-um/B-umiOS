//
//  LoginService.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/11.
//

import Alamofire
import Foundation

struct UserService {
    static let shared = UserService()

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

    func fetchUserInfo(completion: @escaping (Any) -> Void) {
        RequestHandler.shared.requestData(url: APIConstants.loginURL, httpmethod: .get, parameter: nil, header: NetworkInfo.headerWithToken, decodeType: GeneralResponse<UserResponse>.self) { response in
            completion(response)
        }
    }

    func updateUserInfo(userInfo: UserInfo, completion: @escaping (Any) -> Void) {
        let parameter = NetworkInfo.shared.makeParameter(model: userInfo)

        RequestHandler.shared.requestData(url: APIConstants.loginURL, httpmethod: .patch, parameter: parameter, header: NetworkInfo.headerWithToken, decodeType: GeneralResponse<UserResponse>.self) { response in
            completion(response)
        }
    }
}
