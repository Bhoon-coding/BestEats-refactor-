//
//  MenuItemView.swift
//  BestEats
//
//  Created by BH on 2024/07/22.
//

import SwiftUI

struct MenuItemView: View {
    @EnvironmentObject var coreDataManager: CoreDataManager
    @Binding var rateType: Rate
    
    var restaurant: Restaurant
    var menu: Menu
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(menu.wrappedName)
                    .font(.pretendardBold20)
                    .foregroundStyle(.orange)
                    .lineLimit(1)
                
                Spacer()
                
                if rateType == .like {
                    
                    Button {
                        DispatchQueue.main.async {
                            coreDataManager.updateMenu(
                                with: restaurant,
                                id: menu.wrappedId,
                                isFavorite: !menu.isFavorite
                            )
                        }
                    } label: {
                        Image(menu.isFavorite ? Img.starFill : Img.star)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                    .frame(width: 24, height: 24)
                }
            }
            
            Spacer()
            
            VStack {
                Text(menu.wrappedOneLiner)
                    .font(.pretendardSemiBold16)
                    .lineLimit(2)
            }
        }
        .padding(.top)
        .background(.background)
    }
}

#Preview {
    @State var rateType = Rate.like
    let context = CoreDataManager().container.viewContext
    let restaurant = Restaurant(context: context)
    let menu = Menu(context: context)
    restaurant.name = "Sample Restaurant"
    
    menu.id = UUID()
    menu.name = "메뉴이름"
    menu.oneLiner = "한줄평"
    menu.isFavorite = true
    menu.restaurant = restaurant
    
    return MenuItemView(rateType: $rateType, restaurant: restaurant, menu: menu)
        .environment(\.managedObjectContext, context)
        .environmentObject(CoreDataManager())
}
