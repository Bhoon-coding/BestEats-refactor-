//
//  RestaurantCardView.swift
//  BestEats
//
//  Created by BH on 2024/07/19.
//

import SwiftUI

struct RestaurantCardView: View {
    
    @EnvironmentObject var coreDataManager: CoreDataManager
    @State private var showDialog: Bool = false
    @State private var showEditAlert: Bool = false
    @State private var showDeleteAlert: Bool = false
    @State private var showDeleteConfirmAlert: Bool = false
    @State private var newName: String = ""
    
    let columns = [GridItem(.flexible())]
    var restaurant: Restaurant
    var likeMenu: [Menu] { restaurant.MenuList.filter { $0.rate == "like" } }
    var curiousMenu: [Menu] { restaurant.MenuList.filter { $0.rate == "curious" } }
    var badMenu: [Menu] { restaurant.MenuList.filter { $0.rate == "bad" } }
    
    var body: some View {
        LazyVGrid(columns: columns) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(restaurant.wrappedName)
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
                    Button("변경") { updateRestaurant(with: newName) }
                } message: {
                    Text("맛집이름을 변경해주세요")
                }
                
                // 삭제 Alert
                .alert("맛집 삭제", isPresented: $showDeleteAlert) {
                    Button("취소", role: .cancel) {}
                    Button("삭제", role: .destructive) { deleteRestaurant() }
                } message: {
                    Text("맛집에 포함된 메뉴들도 삭제 됩니다\n 삭제하시겠습니까?")
                }
                
                Spacer()
                
                favoriteMenuText(with: restaurant)
                
                Spacer()
                
                // TODO: [] 컴포넌트로 만들기
                HStack(alignment: .center , spacing: 8) {
                    Image("likeFill")
                        .resizable()
                        .frame(width: 16, height: 16)
                    Text("\(likeMenu.count)")
                        .foregroundStyle(.black.opacity(0.5))
                    Image("curiousFill")
                        .resizable()
                        .frame(width: 16, height: 16)
                    Text("\(curiousMenu.count)")
                        .foregroundStyle(.black.opacity(0.5))
                    Image("badFill")
                        .resizable()
                        .frame(width: 16, height: 16)
                    Text("\(badMenu.count)")
                        .foregroundStyle(.black.opacity(0.5))
                }
            }
        }
        .padding(24)
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 16.0))
    }
    
    private func favoriteMenuText(with restaurant: Restaurant) -> Text {
        let favoriteMenus: [Menu] = restaurant.MenuList.filter { $0.isFavorite }
        let sortedMenu: [Menu] = favoriteMenus.sorted(by: { $0.wrappedName < $1.wrappedName })
        
        if let menu = sortedMenu.first {
            let menuText = favoriteMenus.count == 1
            ? "\(menu.wrappedName)"
            : "\(menu.wrappedName) 외 \(favoriteMenus.count - 1)"
        
            return Text(menuText)
                .font(.pretendardBold18)
                .foregroundColor(.green)
        } else {
            return Text("즐겨찾는 메뉴를 추가해보세요 😆")
                .font(.pretendardRegular14)
                .foregroundColor(.green)
        }
    }
    
    private func updateRestaurant(with name: String?) {
        coreDataManager.updateRestaurant(with: restaurant, newName: name)
    }
    
    private func deleteRestaurant() {
        coreDataManager.delete(with: restaurant)
    }
}

//#Preview {
//    RestaurantCardView(restaurant: )
//}
