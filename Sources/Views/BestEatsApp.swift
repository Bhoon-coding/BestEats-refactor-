//
//  BestEatsApp.swift
//  BestEats
//
//  Created by BH on 2024/07/16.
//

import SwiftUI

@main
struct BestEatsApp: App {
    @StateObject var coreDataManager = CoreDataManager()
    @StateObject var toastManager = ToastManager()
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environment(\.managedObjectContext, coreDataManager.container.viewContext)
                .environmentObject(coreDataManager)
                .environmentObject(toastManager)            
        }
    }
}
