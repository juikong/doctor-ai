//
//  Testname+CoreDataProperties.swift
//  doctor-ai
//
//  Created by Juiko Ong on 07/07/2024.
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
    @NSManaged public var revision: Int16
    @NSManaged public var sub: String?

}

extension Testname : Identifiable {

}
