//
//  Restaurant+CoreDataProperties.swift
//  BestEats
//
//  Created by BH on 2024/07/19.
//
//

import Foundation
import CoreData


extension Restaurant {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Restaurant> {
        return NSFetchRequest<Restaurant>(entityName: "Restaurant")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var menu: NSSet?
    
    public var wrappedName: String {
        name ?? "Unknown Restaurant"
    }
    
    public var MenuList: [Menu] {
        let set = menu as? Set<Menu> ?? []
        // MARK: - 즐겨찾기 메뉴를 상단에 표시하고자함
        return set.sorted { $0.isFavorite && $1.isFavorite }
    }

}

// MARK: Generated accessors for menu
extension Restaurant {

    @objc(addMenuObject:)
    @NSManaged public func addToMenu(_ value: Menu)

    @objc(removeMenuObject:)
    @NSManaged public func removeFromMenu(_ value: Menu)

    @objc(addMenu:)
    @NSManaged public func addToMenu(_ values: NSSet)

    @objc(removeMenu:)
    @NSManaged public func removeFromMenu(_ values: NSSet)

}

extension Restaurant : Identifiable {

}
