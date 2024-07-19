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
    @State private var newName: String = ""
    
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
                        self.showDialog.toggle()
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
                                self.showEditAlert.toggle()
                            }
                        
                            Button(role: .destructive) {
                                self.showDeleteAlert.toggle()
                            } label: {
                                Text("삭제")
                            }
                            Button("취소", role: .cancel) {}
                        }, message: {
                            Text("아래 항목을 선택해주세요")
                        })
                }
                // 수정 Alert
                .alert("맛집이름 변경", isPresented: $showEditAlert) {
                    TextField("맛집이름", text: $newName)
                    Button("취소", role: .cancel) {}
                    Button("변경") { update(with: newName) }
                } message: {
                    Text("맛집이름을 변경해주세요")
                }
                
                // 삭제 Alert
                .alert("맛집 삭제", isPresented: $showDeleteAlert) {
                    Button("취소", role: .cancel) {}
                    Button("삭제", role: .destructive) { delete() }
                } message: {
                    Text("맛집에 포함된 메뉴들도 삭제 됩니다\n 삭제하시겠습니까?")
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
    
    private func update(with name: String?) {
        StoreDataManager.shared.updateRestaurant(with: restaurant, newName: name)
    }
    
    private func delete() {
        StoreDataManager.shared.deleteRestaurant(with: restaurant)
    }
}

//#Preview {
//    RestaurantCardView(restaurant: )
//}
