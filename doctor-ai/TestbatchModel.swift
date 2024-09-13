//
//  TestbatchModel.swift
//  doctor-ai
//
//  Created by Juiko Ong on 29/07/2024.
//

import SwiftUI
import CoreData

class TestbatchModel: ObservableObject {
    @Published var testbatch: [Testbatch] = []
    
    func fetchTestbatch() {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<Testbatch> = Testbatch.fetchRequest()
        
        do {
            let items = try context.fetch(fetchRequest)
            DispatchQueue.main.async {
                self.testbatch = items
            }
        } catch {
            print("Failed to fetch items: \(error.localizedDescription)")
        }
    }
    
    func addTestbatch(withBatch batch: Int16) {
        let context = PersistenceController.shared.container.viewContext
        let testbatch = Testbatch(context: context)
        testbatch.id = UUID()
        testbatch.batch = batch
        testbatch.time = Date()
        do {
            try context.save()
        } catch {
            print("Failed to save item: \(error.localizedDescription)")
        }
    }
    
    func deleteTestbatch(withBatch batch: Int16) {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<Testbatch> = Testbatch.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "batch == %i", batch)
        do {
            let items = try context.fetch(fetchRequest)
            for item in items {
                context.delete(item)
            }
            try context.save()
        } catch {
            print("Failed to delete item: \(error.localizedDescription)")
        }
    }
    
    func deleteTestbatches() {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<Testbatch> = Testbatch.fetchRequest()
        do {
            let items = try context.fetch(fetchRequest)
            for item in items {
                context.delete(item)
            }
            try context.save()
        } catch {
            print("Failed to delete item: \(error.localizedDescription)")
        }
    }
}
