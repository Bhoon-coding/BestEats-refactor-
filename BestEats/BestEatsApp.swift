//
//  BestEatsApp.swift
//  BestEats
//
//  Created by BH on 2024/07/16.
//

import SwiftUI

import KakaoMapsSDK

@main
struct BestEatsApp: App {
    @StateObject var coreDataManager = CoreDataManager()
    @StateObject var toastManager = ToastManager()
    
    init() {
        initiateMapSDK()
    }
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environment(\.managedObjectContext, coreDataManager.container.viewContext)
                .environmentObject(coreDataManager)
                .environmentObject(toastManager)
        }
    }
    
    private func initiateMapSDK() {
        guard let kakaoAppKey = Bundle.main.kakaoAppKey else {
            print("kakaoAppKey is not found")
            return
        }
        SDKInitializer.InitSDK(appKey: kakaoAppKey)
        // TODO: [] 인증 실패 처리 ? mapContainer 사용시 필요
    }
}
