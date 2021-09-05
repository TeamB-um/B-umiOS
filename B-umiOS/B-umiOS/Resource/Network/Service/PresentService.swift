//
//  PresentService.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/08/29.
//

import Alamofire
import UIKit

struct PresentService {
    static let shared = PresentService()

    func fetchPresentData(completion: @escaping (Any) -> Void) {
        RequestHandler.shared.requestData(url: APIConstants.presentURL, httpmethod: .get, parameter: nil, header: NetworkInfo.headerWithToken, decodeType: GeneralResponse<PresentResponse>.self) { response in
            completion(response)
        }
    }
}
