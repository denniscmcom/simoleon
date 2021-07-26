//
//  DefaultCurrency+CoreDataProperties.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 21/07/2021.
//
//

import Foundation
import CoreData


extension DefaultCurrency {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<DefaultCurrency> {
        return NSFetchRequest<DefaultCurrency>(entityName: "DefaultCurrency")
    }
    
    @NSManaged public var pair: String?
    
}
