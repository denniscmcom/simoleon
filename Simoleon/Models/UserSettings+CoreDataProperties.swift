//
//  UserSettings+CoreDataProperties.swift
//  Simoleon
//
//  Created by Dennis Concepción Martín on 20/07/2021.
//
//

import Foundation
import CoreData


extension UserSettings {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserSettings> {
        return NSFetchRequest<UserSettings>(entityName: "UserSettings")
    }

    @NSManaged public var defaultCurrency: String?

}

extension UserSettings : Identifiable {

}
