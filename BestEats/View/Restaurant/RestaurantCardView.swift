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
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Button(action: {
                        self.showDialog.toggle()
                    }, label: {
                        Image(systemName: Img.more)
                            .foregroundStyle(.black)
                    })
                }
                
                Spacer()
                
                favoriteMenuText(with: restaurant)
                    .lineLimit(1)
                
                Spacer()
                
                // TODO: [] 컴포넌트로 만들기
                HStack(alignment: .center , spacing: 8) {
                    Image(Img.likeFill)
                        .resizable()
                        .frame(width: 16, height: 16)
                    Text("\(likeMenu.count)")
                        .foregroundStyle(.black.opacity(0.5))
                    Image(Img.curiousFill)
                        .resizable()
                        .frame(width: 16, height: 16)
                    Text("\(curiousMenu.count)")
                        .foregroundStyle(.black.opacity(0.5))
                    Image(Img.badFill)
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
        .confirmationDialog(
            Alerts.Title.Restaurant.setting,
            isPresented: $showDialog,
            titleVisibility: .visible,
            actions: {
                Button(Alerts.Button.update) {
                    self.showEditAlert.toggle()
                }
            
                Button(role: .destructive) {
                    self.showDeleteAlert.toggle()
                } label: {
                    Text(Alerts.Button.delete)
                }
                Button(Alerts.Button.cancel, role: .cancel) {}
            }, message: {
                Text(Alerts.Message.selectBelow)
            })
        
        // 수정 Alert
        .alert(Alerts.Title.Restaurant.update, isPresented: $showEditAlert) {
            TextField(restaurant.wrappedName, text: $newName)
            Button(Alerts.Button.cancel, role: .cancel) {}
            Button(Alerts.Button.update) { updateRestaurant(with: newName) }
        } message: {
            Text(Alerts.Message.Restaurant.update)
        }
        
        // 삭제 Alert
        .alert(Alerts.Title.Restaurant.delete, isPresented: $showDeleteAlert) {
            Button(Alerts.Button.cancel, role: .cancel) {}
            Button(Alerts.Button.delete, role: .destructive) { deleteRestaurant() }
        } message: {
            Text(Alerts.Message.Restaurant.delete)
        }
    }
    
    private func favoriteMenuText(with restaurant: Restaurant) -> Text {
        let favoriteMenus: [Menu] = restaurant.MenuList.filter { $0.isFavorite }
        let sortedMenu: [Menu] = favoriteMenus.sorted(by: { $0.wrappedName < $1.wrappedName })
        
        if let menu = sortedMenu.first {
            let menuText = favoriteMenus.count == 1
            ? menu.wrappedName
            : "\(menu.wrappedName) 외 \(favoriteMenus.count - 1)개"
        
            return Text(menuText)
                .font(.pretendardBold18)
                .foregroundColor(.green)
        } else {
            return Text(Info.favoriteMenuSuggestion)
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
