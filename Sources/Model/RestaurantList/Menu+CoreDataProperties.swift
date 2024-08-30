//
//  Menu+CoreDataProperties.swift
//  BestEats
//
//  Created by BH on 2024/07/19.
//
//

import Foundation
import CoreData


extension Menu {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Menu> {
        return NSFetchRequest<Menu>(entityName: "Menu")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var oneLiner: String?
    @NSManaged public var rate: String?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var restaurant: Restaurant?
    
    public var wrappedId: UUID {
        id ?? UUID()
    }
    
    public var wrappedName: String {
        name ?? ""
    }
    
    public var wrappedOneLiner: String {
        oneLiner ?? ""
    }
    
    public var wrappedRate: String {
        rate ?? ""
    }

}

extension Menu : Identifiable {

}
