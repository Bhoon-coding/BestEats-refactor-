//
//  TabBarView.swift
//  BestEats
//
//  Created by BH on 2024/07/16.
//

import SwiftUI

struct TabBarView: View {
    
    @State var isLoading: Bool = true
    
    let tabs: [TabItem] = [
        TabItem(view: .init(RestaurantView()), icon: "house.fill", title: "홈"),
        TabItem(view: .init(RecommendationView()), icon: "person.fill.questionmark", title: "추천"),
        TabItem(view: .init(SettingsView()), icon: "gearshape.fill", title: "설정")
    ]
    
    var body: some View {
        ZStack {
            if isLoading {
                SplashView()
                    .transition(.opacity)
            } else {
                TabView {
                    ForEach(tabs) { tab in
                        tab.view
                            .tabItem {
                                Image(systemName: tab.icon)
                                Text(tab.title)
                            }
                    }
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
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
