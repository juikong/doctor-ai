//
//  Testbatch+CoreDataProperties.swift
//  doctor-ai
//
//  Created by Juiko Ong on 29/07/2024.
//
//

import Foundation
import CoreData


extension Testbatch {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Testbatch> {
        return NSFetchRequest<Testbatch>(entityName: "Testbatch")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var batch: Int16
    @NSManaged public var time: Date?

}

extension Testbatch : Identifiable {

}
