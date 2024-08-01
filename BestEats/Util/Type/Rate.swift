//
//  Rate.swift
//  BestEats
//
//  Created by BH on 2024/07/25.
//

enum Rate: String, CaseIterable, Identifiable {
    case like = "like"
    case curious = "curious"
    case warning = "warning"
    
    var id: String { self.rawValue }
}
