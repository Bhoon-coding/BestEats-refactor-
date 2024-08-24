//
//  SearchRestaurantService.swift
//  BestEats
//
//  Created by BH on 2024/08/12.
//

import Foundation
import MapKit

import Alamofire

protocol SearchRestaurantServiceable {
    func request(params: V2.Local.Search.Keyword.Params) async throws -> V2.Local.Search.Keyword.Response
}

struct SearchRestaurantService: SearchRestaurantServiceable {
    func request(params: V2.Local.Search.Keyword.Params) async throws -> V2.Local.Search.Keyword.Response {
        let keywordAPI = V2.Local.Search.Keyword(keywordParams: params)
        
        do {
            let response: V2.Local.Search.Keyword.Response = try await NetworkManager.shared.requestJSON(
                path: keywordAPI.path,
                headers: keywordAPI.headers,
                params: keywordAPI.parameters
            )
            return response
        } catch {
            throw error
        }
    }
}

extension V2.Local.Search {
    struct Keyword: APIDefinition {
        
        var path: String = "/v2/local/search/keyword"
        
        var headers: HTTPHeaders?
        
        var parameters: Parameters?
        
        var method: HTTPMethod = .get
        
        init(headers: HTTPHeaders? = nil, keywordParams: Params) {
            guard let apiKey = Bundle.main.kakaoAPIKey else {
                // TODO: [] 에러로그 (Crashlytics)
                print(BestEatsError.NetworkError.invalidKey.messageDescription)
                return
            }
            let headers: HTTPHeaders = [.authorization("KakaoAK \(apiKey)")]
            
            self.headers = headers
            self.parameters = try? keywordParams.encode()
        }
        
        struct Params: Encodable {
            let query: String
            let x: String // longitude (경도)
            let y: String // latitude  (위도)
            let radius: Int = 2000
            let sort: String = "distance"
        }
        
        // TODO: [] nullable 한 속성들만 골라내기
        struct Response: Codable {
            let restaurantInfo: [PlaceInfo]?
            let meta: Meta?
            
            enum CodingKeys: String, CodingKey {
                case restaurantInfo = "documents"
                case meta
            }
            
            // MARK: - PlaceInfo
            /// Identifiable: Map의 annotation Items에 필요
            /// Equatable: .onChange에 필요
            struct PlaceInfo: Codable, Identifiable, Equatable {
                let id = UUID()
                let placeName: String
                let distance: String
                let categoryGroupCode, categoryGroupName, categoryName: String?
                let phone: String?
                let placeURL: String
                let roadAddressName, addressName: String?
                let x, y: String
                var coordinate: CLLocationCoordinate2D {
                    CLLocationCoordinate2D(latitude: Double(y) ?? 0.0, longitude: Double(x) ?? 0.0)
                }
                
                enum CodingKeys: String, CodingKey {
                    case id
                    case categoryGroupCode = "category_group_code"
                    case categoryGroupName = "category_group_name"
                    case categoryName = "category_name"
                    case distance
                    case phone
                    case placeName = "place_name"
                    case placeURL = "place_url"
                    case roadAddressName = "road_address_name"
                    case addressName = "address_name"
                    case x, y
                }
            }

            // MARK: - Meta
            struct Meta: Codable {
                let isEnd: Bool?
                let pageableCount: Int?
                let sameName: SameName?
                let totalCount: Int?
                
                enum CodingKeys: String, CodingKey {
                    case sameName = "same_name"
                    case pageableCount = "pageable_count"
                    case totalCount = "total_count"
                    case isEnd = "is_end"
                }
            }

            // MARK: - SameName
            struct SameName: Codable {
                let keyword: String?
                let region: [String]?
                let selectedRegion: String?
                
                enum CodingKeys: String, CodingKey {
                    case keyword, region
                    case selectedRegion = "selected_region"
                }
            }
        }
        
    }
}
