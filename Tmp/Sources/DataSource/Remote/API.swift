//
//  API.swift
//  BestEats
//
//  Created by BH on 2024/08/12.
//

import Foundation

import Alamofire

struct APICommon {
    static let kakaoHost: String = Bundle.main.kakaoHost ?? ""
}

enum V2 {
    enum Local {
        struct Search { }
    }
}

public protocol APIDefinition {
    var path: String { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    var method: HTTPMethod { get }
}

protocol APIErrorDefinable: Error {
    var httpStatusCode: Int { get }
    var errorMessage: String? { get }
}

struct CommonAPIError: APIErrorDefinable {
    var httpStatusCode: Int
    var errorMessage: String?
}
