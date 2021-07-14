//
//  CategoryService.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/07/14.
//

import Alamofire
import Foundation

struct CategoryService {
    static let shared = CategoryService()

    func fetchCategories(completion: @escaping (Any) -> Void) {
        RequestHandler.shared.requestData(url: APIConstants.categoryURL, httpmethod: HTTPMethod.get, parameter: nil, header: NetworkInfo.headerWithToken, decodeType: GeneralResponse<CategoriesResponse>.self) { response in
            switch response {
            case .success(let data):
                guard let result = data as? GeneralResponse<CategoriesResponse> else { return }

                completion(result.data)
            case .requestErr, .pathErr, .serverErr, .networkFail: break
            }
        }
    }

    func createCategory(category: CategoryRequest, completion: @escaping (Any) -> Void) {
        let parameter = NetworkInfo.shared.makeParameter(model: category)

        RequestHandler.shared.requestData(url: APIConstants.categoryURL, httpmethod: .post, parameter: parameter, header: NetworkInfo.headerWithToken, decodeType: GeneralResponse<CategoriesResponse>.self) { response in
            completion(response)
        }
    }
}
