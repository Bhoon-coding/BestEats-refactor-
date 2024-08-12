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
    var params: Parameters? { get }
    var method: HTTPMethod { get }
}
