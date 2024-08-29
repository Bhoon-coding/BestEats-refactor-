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
                menuNameText
                Spacer()
                if rateType == .like {
                    favoriteButton
                }
            }
            Spacer()
            oneLinerText
        }
        .padding(.top)
        .background(.background)
    }
}

extension MenuItemView {
    private var menuNameText: some View {
        Text(menu.wrappedName)
            .font(BestEatsFontFamily.Pretendard.bold.swiftUIFont(size: 22))
            .foregroundStyle(BestEatsAsset.commonOrange.swiftUIColor)
            .lineLimit(1)
    }
    
    private var favoriteButton: some View {
        Button {
            menu.isFavorite.toggle()
            coreDataManager.updateMenu(
                with: restaurant,
                id: menu.wrappedId,
                name: menu.wrappedName,
                oneLiner: menu.wrappedOneLiner,
                rate: menu.wrappedRate,
                isFavorite: menu.isFavorite
            )
        } label: {
            Image(menu.isFavorite ? Img.starFill : Img.star)
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
        .frame(width: 24, height: 24)
    }
    
    private var oneLinerText: some View {
        Text(menu.wrappedOneLiner)
            .font(BestEatsFontFamily.Pretendard.semiBold.swiftUIFont(size: 16))
            .foregroundStyle(BestEatsAsset.commonBlack.swiftUIColor)
            .lineLimit(2)
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
