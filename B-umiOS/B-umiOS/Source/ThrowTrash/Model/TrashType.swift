//
//  TrashType.swift
//  B-umiOS
//
//  Created by inae Lee on 2021/08/24.
//

import UIKit

enum TrashType {
    case trash(Int)
    case separate

    var mode: String {
        switch self {
        case .trash:
            return "삭제하기"
        case .separate:
            return "보관하기"
        }
    }

    var trashBinName: String {
        switch self {
        case .trash(let mode):
            switch mode {
            case 0:
                return "구름"
            case 1:
                return "모닥불"
            case 2:
                return "파쇄기"
            default:
                return "구름"
            }
        case .separate:
            return "휴지통"
        }
    }

    var explain: String {
        switch self {
        case .trash(let mode):
            switch mode {
            case 0:
                return "날아가 사라집니다"
            case 1:
                return "불타 사라집니다"
            case 2:
                return "찢어져 사라집니다"
            default:
                return "날아가 사라집니다"
            }
        case .separate:
            return "휴지통에 보관됩니다"
        }
    }

    var completionMessage: String {
        switch self {
        case .trash(let mode):
            switch mode {
            case 0:
                return "날려"
            case 1:
                return "불태워"
            case 2:
                return "찢어"
            default:
                return "날려"
            }

        case .separate:
            return "보관되었습니다!"
        }
    }
    
    var logo: UIImage {
        switch self {
        
        case .trash(_):
            return .separateToast
        case .separate:
            return .trashToast
        }
    }
}
