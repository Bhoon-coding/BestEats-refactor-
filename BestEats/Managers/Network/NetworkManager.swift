//
//  NetworkManager.swift
//  BestEats
//
//  Created by BH on 2024/08/12.
//

import Foundation

import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    private let session: Session = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 5
        config.timeoutIntervalForResource = 5
        return Session(configuration: config)
    }()
    
    func requestJSON<T: Codable>(
        host: String = APICommon.kakaoHost,
        path: String,
        method: HTTPMethod = .get,
        params: Parameters? = nil
    ) async throws -> T {
        guard let url = URL(string: host + path) else {
            throw BestEatsError.NetworkError.invalidURL
        }
        
        return try await session.request(
            url,
            method: method,
            parameters: params,
            encoding: URLEncoding.default
        )
        .serializingDecodable()
        .value
    }
    
    
    
    
}
