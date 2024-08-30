//
//  TabItem.swift
//  BestEats
//
//  Created by BH on 2024/08/02.
//

import SwiftUI

struct TabItem: Identifiable {
    var id = UUID()
    var view: AnyView
    var icon: String
    var title: String
}


