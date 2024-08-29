//
//  PlaceInfoError.swift
//  BestEats
//
//  Created by BH on 2024/08/24.
//

enum PlaceInfoError: Error {
    case emptyData
    
    var messageDescription: String {
        switch self {
        case .emptyData:
            return "정보없음"
        }
    }
}
