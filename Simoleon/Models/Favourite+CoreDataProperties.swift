//
//  Favourite+CoreDataProperties.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 19/07/2021.
//
//

import Foundation
import CoreData


extension Favourite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favourite> {
        return NSFetchRequest<Favourite>(entityName: "Favourite")
    }

    @NSManaged public var currencyPair: String

}

extension Favourite : Identifiable {

}
