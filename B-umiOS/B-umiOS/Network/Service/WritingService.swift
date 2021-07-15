//
//  WritingService.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/14.
//

import Alamofire
import Foundation

struct WritingService {
    static let shared = WritingService()

    func createWriting(writing: WritingRequest,completion: @escaping (Bool) -> Void) {
        let parameter = NetworkInfo.shared.makeParameter(model: writing)
        
        RequestHandler.shared.requestData(url: APIConstants.writingURL, httpmethod: HTTPMethod.post, parameter: parameter, header: NetworkInfo.headerWithToken, decodeType: GeneralResponse<WritingsResponse>.self) { response in
            switch response {
            case .success(let data):
                guard let result = data as? GeneralResponse<WritingsResponse> else { return }

                completion(true)
            case .requestErr, .pathErr, .serverErr, .networkFail:
                completion(false)
            }
        }
    }
}
