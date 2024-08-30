//
//  BundleEx.swift
//  BestEats
//
//  Created by BH on 2024/08/12.
//

import Foundation

extension Bundle {
    
    // MARK: - API
    
    var kakaoHost: String? {
        return self.object(forInfoDictionaryKey: "KAKAO_SERVER_HOST") as? String
    }
    
    var kakaoAPIKey: String? {
        return self.object(forInfoDictionaryKey: "KAKAO_API_KEY") as? String
    }
    
    var kakaoAppKey: String? {
        return self.object(forInfoDictionaryKey: "KAKAO_APP_KEY") as? String
    }
    
}
