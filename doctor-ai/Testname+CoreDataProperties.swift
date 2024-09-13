//
//  Testname+CoreDataProperties.swift
//  doctor-ai
//
//  Created by Juiko Ong on 29/07/2024.
//
//

import Foundation
import CoreData


extension Testname {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Testname> {
        return NSFetchRequest<Testname>(entityName: "Testname")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var main: String?
    @NSManaged public var max: String?
    @NSManaged public var revision: Int16
    @NSManaged public var sub: String?
    @NSManaged public var unit: String?

}

extension Testname : Identifiable {

}
