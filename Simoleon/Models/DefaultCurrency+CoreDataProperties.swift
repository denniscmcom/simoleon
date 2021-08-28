//
//  DefaultCurrency+CoreDataProperties.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 24/8/21.
//
//

import Foundation
import CoreData


extension DefaultCurrency {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DefaultCurrency> {
        return NSFetchRequest<DefaultCurrency>(entityName: "DefaultCurrency")
    }

    @NSManaged public var firstSymbol: String
    @NSManaged public var secondSymbol: String

}

extension DefaultCurrency : Identifiable {

}
