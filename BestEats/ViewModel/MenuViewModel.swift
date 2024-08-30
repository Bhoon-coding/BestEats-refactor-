//
//  MenuViewModel.swift
//  BestEats
//
//  Created by BH on 2024/07/22.
//

import SwiftUI

class MenuViewModel: ObservableObject {
    @EnvironmentObject var coreDataManager: CoreDataManager
    @Published var restaurant: Restaurant
    @Published var filteredMenu: [Menu] = []
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
        self.filterMenu(by: .like)
    }
    
    func filterMenu(by rate: Rate) {
        filteredMenu = restaurant.MenuList.filter { $0.rate == rate.rawValue }
    }
    
    func updateIsFavorite(with menu: Menu) {
        menu.isFavorite.toggle()
        
        coreDataManager.updateMenu(
            with: restaurant,
            id: menu.wrappedId,
            isFavorite: menu.isFavorite
        )
        
        DispatchQueue.main.async {
            self.restaurant = menu.restaurant!
        }
    }
    
}
