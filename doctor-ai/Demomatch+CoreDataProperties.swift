//
//  Demomatch+CoreDataProperties.swift
//  doctor-ai
//
//  Created by Juiko Ong on 29/07/2024.
//
//

import Foundation
import CoreData


extension Demomatch {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Demomatch> {
        return NSFetchRequest<Demomatch>(entityName: "Demomatch")
    }

    @NSManaged public var batch: Int16
    @NSManaged public var id: UUID?
    @NSManaged public var main: String?
    @NSManaged public var result: String?
    @NSManaged public var sub: String?

}

extension Demomatch : Identifiable {

}
