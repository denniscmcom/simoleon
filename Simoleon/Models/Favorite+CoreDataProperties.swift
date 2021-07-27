//
//  Favorite+CoreDataProperties.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 19/07/2021.
//
//

import Foundation
import CoreData


extension Favorite {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }
    
    @NSManaged public var currencyPair: String
    
}

extension Favorite : Identifiable {
    
}
