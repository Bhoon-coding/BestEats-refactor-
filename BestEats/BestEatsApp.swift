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
    
    @State var showSplash: Bool = true
    
    var body: some Scene {
        WindowGroup {
            if showSplash {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                self.showSplash = false
                            }
                        }
                    }
            } else {
                TabBarView()
                    .environment(\.managedObjectContext, coreDataManager.container.viewContext)
                    .environmentObject(coreDataManager)
                    .environmentObject(toastManager)
            }
        }
        
    }
}
