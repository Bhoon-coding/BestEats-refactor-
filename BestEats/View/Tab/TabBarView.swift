//
//  TabBarView.swift
//  BestEats
//
//  Created by BH on 2024/07/16.
//

import SwiftUI

struct TabBarView: View {
    
    @State var isLoading: Bool = true
    @State var draw: Bool = false // 뷰의 appear 상태를 전달하기 위한 변수
    
    var body: some View {
        ZStack {
            if isLoading {
                SplashView()
                    .transition(.opacity)
            } else {
                TabView {
                    RestaurantView()
                        .tabItem {
                            Image(systemName: Img.house)
                            Text(Tab.home)
                        }
                    KakaoMapView(draw: $draw)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .onAppear { self.draw = true }
                        .onDisappear { self.draw = false }
                        .tabItem {
                            Image(systemName: Img.map)
                            Text(Tab.map)
                        }
//                    SettingsView()
//                        .tabItem {
//                            Image(systemName: Img.setting)
//                            Text(Tab.setting)
//                        }
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
