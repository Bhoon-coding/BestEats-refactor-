//
//  BestEatsError.swift
//  BestEats
//
//  Created by BH on 2024/08/12.
//

import Foundation

enum BestEatsError: Error {
    // MARK: - Network
    enum NetworkError: Error {
        case invalidURL
        case timeout
        case unavailable
        case parsingFail
        case emptyData
        case invalidKey
        
        var messageDescription: String {
            switch self {
            case .invalidURL:
                return "유효한 URL이 아닙니다"
            case .timeout:
                return "네트워크가 불안정합니다\n 잠시후 다시 시도해주세요"
            case .unavailable:
                return "네트워크 연결을 확인해주세요"
            case .parsingFail:
                return "데이터를 변환하는데 실패했습니다"
            case .emptyData:
                return "데이터가 없습니다"
            case .invalidKey:
                return "유효한 Key가 아닙니다"
            }
        }
    }
    
    // MARK: - <#표시할 말#>
}
