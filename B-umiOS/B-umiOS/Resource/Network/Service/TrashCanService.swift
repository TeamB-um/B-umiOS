//
//  TrashCanService.swift
//  B-umiOS
//
//  Created by kong on 2021/07/15.
//

import Alamofire
import Foundation

struct TrashCanService {
    static let shared = TrashCanService()
    
    func fatchTrashCanData(completion: @escaping (Any) -> Void) {
        RequestHandler.shared.requestData(url: APIConstants.trashCanURL, httpmethod: HTTPMethod.get, parameter: nil, header: NetworkInfo.headerWithToken, decodeType: GeneralResponse<TrashCanResponse>.self) { response in
            completion(response)
        }
    }
}
