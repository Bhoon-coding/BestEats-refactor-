//
//  MenuView.swift
//  BestEats
//
//  Created by BH on 2024/07/19.
//

import SwiftUI

struct MenuView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var coreDataManager: CoreDataManager
    @State var rateType: Rate = Rate.like
    @State var showAddView: Bool = false
    
    let columns = [GridItem(.flexible())]
    var restaurant: Restaurant
    
    var body: some View {
        Self._printChanges()
        
        return VStack {
            VStack(spacing: 8) {
                CategoryView(rateType: $rateType, restaurant: restaurant)
                    .padding(.top)
                
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(coreDataManager.filteredMenu, id: \.self) { menu in
                            NavigationLink {
                                MenuDetailView(
                                    rateType: $rateType,
                                    restaurant: restaurant,
                                    menu: menu
                                )
                            } label: {
                                MenuItemView(
                                    rateType: $rateType,
                                    restaurant: restaurant,
                                    menu: menu
                                )
                            }
                        }
                    }
                }
                .padding(24)
            }
        }
        .onAppear { coreDataManager.fetchMenu(with: restaurant, rateType) }
        .background(.gray.opacity(0.1))
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(self.restaurant.wrappedName)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("추가") { self.showAddView.toggle() }
                    .font(.pretendardBold18)
                    .foregroundStyle(.black)
            }
            ToolbarItem(placement: .topBarLeading) { BackButton() }
        }
        .sheet(isPresented: $showAddView) {
            AddMenuSheet(rateType: $rateType, restaurant: restaurant)
        }
    }
}

#Preview {
    let context = CoreDataManager().context
    let restaurant = Restaurant(context: context)
    let menu = Menu(context: context)
    restaurant.id = UUID()
    restaurant.name = "스벅"
    
    menu.id = UUID()
    menu.isFavorite = false
    menu.name = "아아"
    menu.oneLiner = "soso"
    menu.rate = Rate.like.rawValue
    
    menu.restaurant = restaurant
    
    let menu2 = Menu(context: context)
    menu2.id = UUID()
    menu2.isFavorite = true
    menu2.name = "자허블"
    menu2.oneLiner = "good"
    menu2.rate = Rate.like.rawValue
    
    menu2.restaurant = restaurant
    
    return MenuView(restaurant: restaurant)
        .environment(\.managedObjectContext, context)
        .environmentObject(CoreDataManager())
}
