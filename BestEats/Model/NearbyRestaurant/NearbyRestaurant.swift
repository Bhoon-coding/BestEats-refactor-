//
//  NearbyRestaurant.swift
//  BestEats
//
//  Created by BH on 2024/08/12.
//

// MARK: - NearbyRestaurant
struct NearbyRestaurant: Codable {
    let restaurantInfo: [RestaurantInfo]
    let meta: Meta
    
    enum CodingKeys: String, CodingKey {
        case restaurantInfo = "documents"
        case meta
    }
}

// MARK: - RestaurantInfo
struct RestaurantInfo: Codable {
    let id: String
    let categoryGroupCode, categoryGroupName, categoryName: String
    let distance, phone: String
    let placeName, placeURL: String
    let roadAddressName, addressName: String
    let x, y: String
    
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
    let isEnd: Bool
    let pageableCount: Int
    let sameName: SameName
    let totalCount: Int
    
    enum CodingKeys: String, CodingKey {
        case sameName = "same_name"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
        case isEnd = "is_end"
    }
}

// MARK: - SameName
struct SameName: Codable {
    let keyword: String
    let region: [String]
    let selectedRegion: String
    
    enum CodingKeys: String, CodingKey {
        case keyword, region
        case selectedRegion = "selected_region"
    }
}
