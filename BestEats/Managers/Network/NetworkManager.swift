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
        config.timeoutIntervalForRequest = 10
        config.timeoutIntervalForResource = 10
        return Session(configuration: config)
    }()
    
    func requestJSON<T: Codable>(
        host: String = APICommon.kakaoHost,
        path: String,
        method: HTTPMethod = .get,
        headers: HTTPHeaders? = nil,
        params: Parameters? = nil
    ) async throws -> T {
        
        guard let url = URL(string: host + path) else {
            throw BestEatsError.NetworkError.invalidURL
        }
        
        let dataTask = session.request(
            url,
            method: method,
            parameters: params,
            encoding: URLEncoding.default,
            headers: headers
        )
            .serializingDecodable(T.self)
        
        let res = await dataTask.response
        let result = await dataTask.result
        let requestHost: String = res.request?.url?.host ?? ""
        let requestPath: String = res.request?.url?.path ?? ""
        let requestURL: String = res.request?.url?.absoluteString ?? ""
        let responseBodyString: String = String(data: res.data ?? Data(), encoding: .utf8) ?? ""
        let statusCode: Int = res.response?.statusCode ?? -1
        
        switch result {
        case .success(let response):
            print("========= Response 🎁 =========")
            print("||")
            print("|| host : \(requestHost)")
            print("|| request path : \(requestPath)")
            print("|| request url : \(requestURL)")
            print("|| request headers : \(res.request?.headers ?? [:])")
            print("|| response body : \(responseBodyString)")
            print("|| http Code : \(statusCode)")
            print("||")
            print("==============================")
            
        case .failure(let afError):
            print(afError)
            print("========= Error 😢 ===========")
            print("||")
            print("|| host : \(requestHost)")
            print("|| request path : \(requestPath)")
            print("|| request url : \(requestURL)")
            print("|| request headers : \(res.request?.headers ?? [:])")
            print("|| response body : \(responseBodyString)")
            print("|| http Code : \(statusCode)")
            print("||")
            print("==============================")
            
            throw CommonAPIError.init(httpStatusCode: statusCode, errorMessage: afError.localizedDescription)
        }
        
        do {
            let value = try await dataTask.value
            return value
        } catch {
            throw CommonAPIError(httpStatusCode: statusCode, errorMessage: error.localizedDescription)
        }
    }
}
