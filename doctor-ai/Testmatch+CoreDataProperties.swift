//
//  Testmatch+CoreDataProperties.swift
//  doctor-ai
//
//  Created by Juiko Ong on 29/07/2024.
//
//

import Foundation
import CoreData


extension Testmatch {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Testmatch> {
        return NSFetchRequest<Testmatch>(entityName: "Testmatch")
    }

    @NSManaged public var batch: Int16
    @NSManaged public var id: UUID?
    @NSManaged public var main: String?
    @NSManaged public var result: String?
    @NSManaged public var sub: String?

}

extension Testmatch : Identifiable {

}
