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
            completion(response)
        }
    }

    func fetchCategoryWritings(categories: String, completion: @escaping (Any) -> Void) {
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

    func deleteCategory(id: String, completion: @escaping (Any) -> Void) {
        RequestHandler.shared.requestData(url: APIConstants.categoryURL +
            "/\(id)", httpmethod: .delete, parameter: nil, header: NetworkInfo.headerWithToken, decodeType: GeneralResponse<CategoriesResponse>.self) { response in
            completion(response)
        }
    }
    
    func fetchRewardData(category_id: String, completion: @escaping (Any) -> Void) {
        let url = "\(APIConstants.categoryURL)/\(category_id)/rewards"
        RequestHandler.shared.requestData(url: url, httpmethod: HTTPMethod.get, parameter: nil, header: NetworkInfo.headerWithToken, decodeType: GeneralResponse<RewardResponse>.self) { response in
            completion(response)
        }
    }
    
    func fetchGraphData(completion: @escaping (Any) -> Void) {
        RequestHandler.shared.requestData(url: APIConstants.categoryGraphURL, httpmethod: HTTPMethod.get, parameter: nil, header: NetworkInfo.headerWithToken, decodeType: GeneralResponse<GraphResponse>.self) { response in
            completion(response)
        }
    }

}
