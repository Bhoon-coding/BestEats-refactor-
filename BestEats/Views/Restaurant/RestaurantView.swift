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
        NavigationView {
            ScrollView {
                RestaurantCardView()
                    .padding(.horizontal, 24)
                    .shadow(radius: 4, x: 8, y: 8)
                    .padding(.bottom, 16)
                
                AddRestaurantCardView()
            }
            .background(.gray.opacity(0.1))
            .navigationBarBackButtonHidden(true)
            .searchable(text: $searchText, prompt: "맛집을 검색해주세요")
        }
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
                        .font(.pretendardBold24)
                        .foregroundStyle(.orange)
                    
                    Spacer()
                    
                    Button(action: {
                        // TODO: [] Alert(BottomSheet)
                    }, label: {
                        Image(systemName: "ellipsis")
                            .foregroundStyle(.black)
                    })
                }
                
                Spacer()
                
                Text("Menu")
                    .font(.pretendardBold18)
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

struct AddRestaurantCardView: View {
    @State private var isPresented = false
    
    var body: some View {
        ZStack {
            Button {
                self.isPresented.toggle()
            } label: {
                HStack {
                    Image(systemName: "plus")
                    Text("맛집 추가")
                }
                .font(.pretendardBold18)
                .foregroundStyle(.gray)
                .padding(.vertical, 12)
                .padding(.horizontal, 40)
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                    .stroke(.gray.opacity(0.5), lineWidth: 2)
                )
            }
            .padding(.vertical, 40)
            .sheet(
                isPresented: $isPresented,
                content: { RestaurantDetailView() }
            )
        }
        .frame(maxWidth: .infinity)
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal, 24)
        .shadow(radius: 4, x: 8, y: 8)
    }
}
