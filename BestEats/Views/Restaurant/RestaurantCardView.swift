//
//  RestaurantCardView.swift
//  BestEats
//
//  Created by BH on 2024/07/19.
//

import SwiftUI

struct RestaurantCardView: View {
    
    @State private var showDialog: Bool = false
    @State private var showEditAlert: Bool = false
    @State private var showDeleteAlert: Bool = false
    @State private var showDeleteConfirmAlert: Bool = false
    
    let columns = [GridItem(.flexible())]
    var restaurant: Restaurant
    
    var body: some View {
        LazyVGrid(columns: columns) {
            // TODO: [] 데이터가 없을 경우의 맛집추가 유도 카드 필요
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(restaurant.name ?? "unknowned restaurant")
                        .font(.pretendardBold24)
                        .foregroundStyle(.orange)
                    
                    Spacer()
                    
                    Button(action: {
                        self.showDialog = true
                    }, label: {
                        Image(systemName: "ellipsis")
                            .foregroundStyle(.black)
                    })
                    .confirmationDialog(
                        "맛집 설정",
                        isPresented: $showDialog,
                        titleVisibility: .visible,
                        actions: {
                            Button("변경") {
                                // 변경 alert 띄우기
                                print("변경")
                            }
                            Button(role: .destructive) {
                                StoreDataManager.shared.deleteRestaurant(with: restaurant)
                            } label: {
                                Text("삭제")
                            }
                            Button("취소", role: .cancel) {}
                        }, message: {
                            Text("아래 항목을 선택해주세요")
                        })
                }
                
                Spacer()
                Text(restaurant.MenuList.first?.wrappedName ?? "메뉴가 없음")
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
    
    private func delete(_ entity: Restaurant) {
        
    }
}

//#Preview {
//    RestaurantCardView(restaurant: )
//}
