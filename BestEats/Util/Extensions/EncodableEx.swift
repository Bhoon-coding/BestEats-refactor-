//
//  EncodableEx.swift
//  BestEats
//
//  Created by BH on 2024/08/15.
//

import Foundation

extension Encodable {
    func encode() throws -> [String: Any] {
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        
        guard let dictionary = try JSONSerialization.jsonObject(
            with: data,
            options: .fragmentsAllowed
        ) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
