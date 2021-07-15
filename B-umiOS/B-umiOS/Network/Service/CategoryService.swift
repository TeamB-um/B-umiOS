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
<<<<<<< HEAD
    
    ///카테고리 글 조회임을 알 수 있게 이름 리네임 부탁드립니다.
=======

>>>>>>> f636794fdb353e4e20719ac878ea3760ef93e2ff
    func fetchWritings(categories: String, completion: @escaping (Any) -> Void) {
        let url = "\(APIConstants.writingURL)?category_ids=[\(categories)]"

        RequestHandler.shared.requestData(url: url, httpmethod: HTTPMethod.get, parameter: nil, header: NetworkInfo.headerWithToken, decodeType: GeneralResponse<WritingsResponse>.self) { response in
            completion(response)
        }
    }

    func createCategory(category: CategoryRequest, completion: @escaping (Any) -> Void) {
        let parameter = NetworkInfo.shared.makeParameter(model: category)

        RequestHandler.shared.requestData(url: APIConstants.categoryURL, httpmethod: .post, parameter: parameter, header: NetworkInfo.headerWithToken, decodeType: GeneralResponse<CategoriesResponse>.self) { response in
            completion(response)
        }
    }

    func updateCategory(id: String, category: CategoryRequest, completion: @escaping (Any) -> Void) {
        let parameter = NetworkInfo.shared.makeParameter(model: category)

        RequestHandler.shared.requestData(url: APIConstants.categoryURL + "/\(id)", httpmethod: .patch, parameter: parameter, header: NetworkInfo.headerWithToken, decodeType: GeneralResponse<CategoriesResponse>.self) { response in
            completion(response)
        }
    }
}
