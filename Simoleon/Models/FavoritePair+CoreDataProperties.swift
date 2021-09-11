//
//  FavoritePair+CoreDataProperties.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 28/8/21.
//
//

import Foundation
import CoreData


extension FavoritePair {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritePair> {
        return NSFetchRequest<FavoritePair>(entityName: "FavoritePair")
    }

    @NSManaged public var baseSymbol: String
    @NSManaged public var quoteSymbol: String

}

extension FavoritePair : Identifiable {

}
