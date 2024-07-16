//
//  Item.swift
//  BestEats
//
//  Created by BH on 2024/07/16.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
