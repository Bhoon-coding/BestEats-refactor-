//
//  BundleEx.swift
//  BestEats
//
//  Created by BH on 2024/08/07.
//

import Foundation

extension Bundle {
    
    var kakaoAppKey: String? {
        return self.object(forInfoDictionaryKey: "KAKAO_APP_KEY") as? String
    }
    
}
