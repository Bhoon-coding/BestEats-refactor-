//
//  BestEatsApp.swift
//  BestEats
//
//  Created by BH on 2024/07/16.
//

import SwiftUI

@main
struct BestEatsApp: App {
    let storeDataManager = StoreDataManager.shared
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environment(\.managedObjectContext, storeDataManager.container.viewContext)
        }
        
    }
}
