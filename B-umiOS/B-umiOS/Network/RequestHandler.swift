//
//  RequestHandler.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/11.
//

import Foundation
import Alamofire

struct RequestHandler {
    static let shared = RequestHandler()
    
    func judgeStatus<T : Codable>(by statusCode : Int, _ data : Data, _ decodeType : T.Type) -> NetworkResult<Any>{
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(decodeType, from: data)
        else{return .serverErr}
        switch statusCode {
        case 200: return .success(decodedData)
        case 400: return .requestErr("")
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    func requestData<T : Codable> (url : String, httpmethod : HTTPMethod, parameter : Parameters?, header : HTTPHeaders, decodeType : T.Type,completion: @escaping (NetworkResult<Any>) -> Void){
        //get인 경우 parameter에 nil 넣기
        let dataRequest = AF.request(url,
                                     method: httpmethod,
                                     parameters: parameter,
                                     encoding: JSONEncoding.default,
                                     headers: header).validate(statusCode: 200...500)
        
        dataRequest.responseData { response in
            switch response.result{
            
            case .success :
                guard let statusCode =  response.response?.statusCode else { return }
                guard let value =  response.value else{return}
                
                let networkResult = self.judgeStatus(by : statusCode, value, decodeType)
                
                completion(networkResult)
                
            case .failure:
                completion(.serverErr)
            }
        }
    }
}
