//
//  Item+CoreDataProperties.swift
//  doctor-ai
//
//  Created by Juiko Ong on 29/07/2024.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var id: Int16
    @NSManaged public var parameter: String?
    @NSManaged public var stringvalue: String?

}

extension Item : Identifiable {

}
