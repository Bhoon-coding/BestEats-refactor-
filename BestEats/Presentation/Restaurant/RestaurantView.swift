//
//  RestaurantView.swift
//  BestEats
//
//  Created by BH on 2024/07/16.
//

import SwiftUI

struct RestaurantView: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                RestaurantCardView()
                    .padding(.horizontal, 24)
                    .shadow(radius: 4, x: 8, y: 8)
            }
            .background(.gray.opacity(0.1))
        }
        .searchable(text: $searchText, prompt: "맛집을 검색해주세요")
    }
}

#Preview {
    RestaurantView()
}

struct RestaurantCardView: View {
    let columns = [GridItem(.flexible())]
    
    var body: some View {
        LazyVGrid(columns: columns) {
            // TODO: [] 데이터가 없을 경우의 맛집추가 유도 카드 필요
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Restaurant")
                        .font(.system(size: 20, weight: .bold)) // TODO: [] 폰트스타일 적용
                        .foregroundStyle(.orange)
                    
                    Spacer()
                    
                    Button(action: {
                        // TODO: [] Alert
                    }, label: {
                        Image(systemName: "ellipsis")
                            .foregroundStyle(.black)
                    })
                }
                
                Spacer()
                
                Text("Menu")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.green)
                
                Spacer()
                
                HStack(alignment: .center , spacing: 8) {
                    Image("likeFill")
                        .resizable()
                        .frame(width: 16, height: 16)
                    Text("23")
                        .foregroundStyle(.black.opacity(0.5))
                    Image("curiousFill")
                        .resizable()
                        .frame(width: 16, height: 16)
                    Text("1")
                        .foregroundStyle(.black.opacity(0.5))
                    Image("warningFill")
                        .resizable()
                        .frame(width: 16, height: 16)
                    Text("10")
                        .foregroundStyle(.black.opacity(0.5))
                }
            }
        }
        .padding()
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 16.0))
    }
}
