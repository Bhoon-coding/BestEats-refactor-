//
//  TabBarView.swift
//  BestEats
//
//  Created by BH on 2024/07/16.
//

import SwiftUI

struct TabBarView: View {
    
    @State var isLoading: Bool = true
    
    var body: some View {
        ZStack {
            if isLoading {
                SplashView()
                    .transition(.opacity)
            } else {
                TabView {
                    RestaurantView()
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("홈")
                        }
                    RecommendationView()
                        .tabItem {
                            Image(systemName: "person.fill.questionmark")
                            Text("추천")
                        }
                    SettingsView()
                        .tabItem {
                            Image(systemName: "gearshape.fill")
                            Text("설정")
                        }
                }
            }
        }
        .onAppear {
            // TODO: [] 추후 데이터 fetch시간이 걸리는경우 로딩 구현
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                withAnimation {
                    isLoading = false
                }
            }
        }
    }
}

#Preview {
    TabBarView()
}
