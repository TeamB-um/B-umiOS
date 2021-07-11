//
//  NetworkResult.swift
//  B-umiOS
//
//  Created by 홍진석 on 2021/07/11.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
