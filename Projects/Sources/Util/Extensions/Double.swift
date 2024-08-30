//
//  Double.swift
//  BestEats
//
//  Created by BH on 2024/08/23.
//

import Foundation

extension Double {
    func convertedDistance() -> String {
        if self >= 1000 {
            let kmValue = self / 1000
           return String(format: "%.1f km", kmValue) // 소수점 첫째자리까지
        } else {
            return String(format: "%.0f m", self)
        }
    }
}
