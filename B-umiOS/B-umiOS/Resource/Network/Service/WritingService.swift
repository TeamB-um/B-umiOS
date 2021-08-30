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

    func createWriting(writing: WritingRequest,completion: @escaping (Any) -> Void) {
        let parameter = NetworkInfo.shared.makeParameter(model: writing)
        
        RequestHandler.shared.requestData(url: APIConstants.writingURL, httpmethod: HTTPMethod.post, parameter: parameter, header: NetworkInfo.headerWithToken, decodeType: GeneralResponse<WritingsResponse>.self) { response in
            completion(response)
        }
    }
    
    func fetchWriting(completion: @escaping (Any) -> Void) {
        RequestHandler.shared.requestData(url: APIConstants.writingURL, httpmethod: HTTPMethod.get, parameter: nil, header: NetworkInfo.headerWithToken, decodeType: GeneralResponse<WritingsResponse>.self) { response in
            completion(response)
        }
    }
    
    func deleteWriting(writings: String, start_date: String, end_date: String, category_id: String, completion: @escaping (Any) -> Void) {
        var url = ""
        
        if category_id == "" {
            url = "\(APIConstants.writingURL)?ids=[\(writings)]&start_date=\(start_date)&end_date=\(end_date)"
        } else {
            url = "\(APIConstants.writingURL)?ids=[\(writings)]&start_date=\(start_date)&end_date=\(end_date)&category_ids=[\(category_id)]"
        }

        RequestHandler.shared.requestData(url: url, httpmethod: HTTPMethod.delete, parameter: nil, header: NetworkInfo.headerWithToken, decodeType: GeneralResponse<WritingsResponse>.self) { response in
            completion(response)
        }
    }
    
    func filterWritings(start_date: String, end_date: String, category_id: String, completion: @escaping (Any) -> Void) {
        var url = ""
        
        if category_id == "" {
            url = "\(APIConstants.writingURL)?start_date=\(start_date)&end_date=\(end_date)"
        } else {
            url = "\(APIConstants.writingURL)?start_date=\(start_date)&end_date=\(end_date)&category_ids=[\(category_id)]"
        }
        
        RequestHandler.shared.requestData(url: url, httpmethod: HTTPMethod.get, parameter: nil, header: NetworkInfo.headerWithToken, decodeType: GeneralResponse<WritingsResponse>.self) { response in
            completion(response)
        }
    }
}
