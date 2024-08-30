//
//  Rate.swift
//  BestEats
//
//  Created by BH on 2024/07/25.
//

enum Rate: String, CaseIterable, Identifiable {
    case like = "like"
    case curious = "curious"
    case bad = "bad"
    
    var id: String { self.rawValue }
}
