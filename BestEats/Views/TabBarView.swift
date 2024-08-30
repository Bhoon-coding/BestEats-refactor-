//
//  TabBarView.swift
//  BestEats
//
//  Created by BH on 2024/07/16.
//

import SwiftUI

struct TabBarView: View {
    
    var body: some View {
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

#Preview {
    TabBarView()
}
