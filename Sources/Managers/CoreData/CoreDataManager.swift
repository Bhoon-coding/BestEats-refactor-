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
    
    // MARK: - Add
    
    func addRestaurant(
        _ restaurantName: String,
        _ menuName: String,
        _ oneLiner: String,
        _ rateType: Rate,
        _ isFavorite: Bool
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
        newMenu.isFavorite = isFavorite
        
        saveContext()
    }
    
    func addMenu(
        with restaurant: Restaurant,
        _ name: String,
        _ oneLiner: String,
        _ rateType: Rate,
        _ isFavorite: Bool
    ) {
        let newMenu = Menu(context: context)
        
        newMenu.id = UUID()
        newMenu.name = name
        newMenu.oneLiner = oneLiner
        newMenu.rate = rateType.rawValue
        newMenu.isFavorite = isFavorite
        newMenu.restaurant = restaurant
        
        fetchMenu(with: restaurant, rateType)
    }
    
    // MARK: - Update
    
    func updateRestaurant(with restaurant: Restaurant, newName: String? = nil) {
        if let newName = newName {
            restaurant.name = newName
            saveContext()
        }
    }
    
    func updateMenu(
        with restaurant: Restaurant,
        id menuId: UUID,
        name menuName: String,
        oneLiner menuOneLiner: String,
        rate menuRate: String,
        isFavorite: Bool = false
    ) {
        guard let menuSet = restaurant.menu as? Set<Menu> else {
            print("No menu in restaurant")
            return
        }
        
        if let menu = menuSet.first(where: { $0.id == menuId }) {
            menu.name = menuName
            menu.oneLiner = menuOneLiner
            menu.rate = menuRate
            menu.isFavorite = isFavorite
            saveContext()
        }
    }
    
    // MARK: - Delete
    
    func delete(with object: NSManagedObject) {
        context.delete(object)
        saveContext()
    }
    
    // MARK: - Private
    
    private func saveContext() {
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
    
    private func fetchRestaurant() {
        let request = NSFetchRequest<Restaurant>(entityName: "Restaurant")
        do {
            self.savedRestaurant = try context.fetch(request)
        } catch {
            print("Fetch Error: \(error.localizedDescription)")
        }
    }
    
    // TODO: [] Private으로 만들기
    func fetchMenu(with restaurant: Restaurant, _ type: Rate) {
        let sortedMenu: [Menu] = restaurant.MenuList.sorted(by: { $0.wrappedName < $1.wrappedName })
        self.filteredMenu = sortedMenu.filter { $0.rate == type.rawValue }
    }
    
}
