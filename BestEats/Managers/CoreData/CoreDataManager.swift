//
//  CoreDataManager.swift
//  BestEats
//
//  Created by BH on 2024/07/18.
//

import CoreData
import Foundation

final class CoreDataManager: ObservableObject {
    
    @Published var savedRestaurant: [Restaurant] = []
    @Published var filteredMenu: [Menu] = []
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        self.container = NSPersistentContainer(name: "RestaurantList")
        self.container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("Unresolved error: \(error), \(error.localizedDescription)")
            }
        }
        self.context = self.container.viewContext
        fetchRestaurant()
    }
    
    private func fetchRestaurant() {
        let request = NSFetchRequest<Restaurant>(entityName: "Restaurant")
        do {
            self.savedRestaurant = try context.fetch(request)
        } catch {
            print("Fetch Error: \(error.localizedDescription)")
        }
    }
    
    func fetchMenu(with restaurant: Restaurant, _ type: Rate) {
        self.filteredMenu = restaurant.MenuList.filter { $0.rate == type.rawValue }
    }
    
    func addRestaurant(
        _ restaurantName: String,
        _ menuName: String,
        _ oneLiner: String,
        _ rateType: Rate
    ) {
        let newRestaurant = Restaurant(context: context)
        let newMenu = Menu(context: context)
        
        newRestaurant.id = UUID()
        newRestaurant.name = restaurantName
        
        newMenu.id = UUID()
        newMenu.name = menuName
        newMenu.oneLiner = oneLiner
        newMenu.rate = rateType.rawValue
        newMenu.restaurant = newRestaurant
        
        saveContext()
    }
    
    func updateRestaurant(with restaurant: Restaurant, newName: String? = nil) {
        if let newName = newName {
            restaurant.name = newName
            saveContext()
        }
    }
    
    func updateMenu(
        with restaurant: Restaurant,
        id menuId: UUID,
        name menuName: String? = nil,
        oneLiner menuOneLiner: String? = nil,
        rate menuRate: String? = nil,
        isFavorite: Bool = false
    ) {
        guard let menuSet = restaurant.menu as? Set<Menu> else {
            print("No menu in restaurant")
            return
        }
        
        if let menu = menuSet.first(where: { $0.id == menuId }) {
            if let name = menuName {
                menu.name = name
            }
            
            if let oneLiner = menuOneLiner {
                menu.oneLiner = oneLiner
            }
            
            if let rate = menuRate {
                menu.rate = rate
            }
            
            menu.isFavorite = !isFavorite
            saveContext()
        }
    }
    
    func deleteRestaurant(with restaurant: Restaurant) {
        context.delete(restaurant)
        saveContext()
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
                fetchRestaurant()
            } catch {
                let error = error as NSError
                print("Unresolved error: \(error.localizedDescription)")
            }
        }
    }
    
}
