//
//  Testresult+CoreDataProperties.swift
//  doctor-ai
//
//  Created by Juiko Ong on 29/07/2024.
//
//

import Foundation
import CoreData


extension Testresult {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Testresult> {
        return NSFetchRequest<Testresult>(entityName: "Testresult")
    }

    @NSManaged public var batch: Int16
    @NSManaged public var id: UUID?
    @NSManaged public var result: String?

}

extension Testresult : Identifiable {

}
