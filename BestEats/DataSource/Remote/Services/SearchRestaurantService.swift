//
//  SearchRestaurantService.swift
//  BestEats
//
//  Created by BH on 2024/08/12.
//

import Foundation

import Alamofire

protocol SearchRestaurantServiceable {
    func fetchNearbyRestaurant(keyword: Parameters) async throws -> [RestaurantInfo]
}

struct SearchRestaurantService: SearchRestaurantServiceable {
    func fetchNearbyRestaurant(keyword: Parameters) async throws -> [RestaurantInfo] {
        let keywordAPI = V2.Local.Search.Keyword(params: keyword)
        let data: NearbyRestaurant = try await NetworkManager.shared.requestJSON(
            path: keywordAPI.path,
            params: keyword
        )
        
        return data.restaurantInfo
    }
}

extension V2.Local.Search {
    struct Keyword: APIDefinition {
        var path: String = "/v2/local/search/keyword"
        
        var headers: HTTPHeaders?
        
        var params: Parameters?
        
        var method: HTTPMethod = .get
        
        init(params: Parameters? = nil) {
            guard let apiKey = Bundle.main.kakaoAPIKey else {
                // TODO: [] 에러로그 (Crashlytics)
                print(BestEatsError.NetworkError.invalidKey.messageDescription)
                return
            }
            self.headers = HTTPHeaders(
                ["Authorization": "KakaoAK \(apiKey)"]
            )
            self.params = params
        }
        
    }
}
