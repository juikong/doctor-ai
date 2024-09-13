//
//  TestmatchModel.swift
//  doctor-ai
//
//  Created by Juiko Ong on 06/07/2024.
//

import SwiftUI
import CoreData

class TestmatchModel: ObservableObject {
    @Published var testmatch: [Testmatch] = []
    @Published var haematologyTestmatch: [Testmatch] = []
    @Published var biochemistryTestmatch: [Testmatch] = []
    @Published var serologyTestmatch: [Testmatch] = []
    @Published var microbiologyTestmatch: [Testmatch] = []
    @Published var othersTestmatch: [Testmatch] = []
    
    func fetchTestmatch() {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<Testmatch> = Testmatch.fetchRequest()
        
        do {
            let items = try context.fetch(fetchRequest)
            DispatchQueue.main.async {
                self.testmatch = items
            }
        } catch {
            print("Failed to fetch items: \(error.localizedDescription)")
        }
    }
        
    func fetchTestmatchMain(withMain main: String) {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<Testmatch> = Testmatch.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "main == %@", main)
        
        do {
            let items = try context.fetch(fetchRequest)
            DispatchQueue.main.async {
                self.testmatch = items
            }
        } catch {
            print("Failed to fetch items: \(error.localizedDescription)")
        }
    }

    func fetchTestmatchSub(withSub sub: String) {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<Testmatch> = Testmatch.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "sub == %@", sub)
        
        do {
            let items = try context.fetch(fetchRequest)
            DispatchQueue.main.async {
                self.testmatch = items
            }
        } catch {
            print("Failed to fetch items: \(error.localizedDescription)")
        }
    }
    
    func fetchTestmatchBatch(withBatch batch: Int16) {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<Testmatch> = Testmatch.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "batch == %i", batch)
        
        do {
            let items = try context.fetch(fetchRequest)
            DispatchQueue.main.async {
                self.testmatch = items
            }
        } catch {
            print("Failed to fetch items: \(error.localizedDescription)")
        }
    }
    
    func fetchTestmatchMainBatch(withMain main: String, Batch batch: Int16) {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<Testmatch> = Testmatch.fetchRequest()
        let mainPredicate = NSPredicate(format: "main == %@", main)
        let batchPredicate = NSPredicate(format: "batch == %i", batch)
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [mainPredicate, batchPredicate])
        fetchRequest.predicate = compoundPredicate
        
        do {
            let items = try context.fetch(fetchRequest)
            DispatchQueue.main.async {
                switch main {
                case "Haematology":
                    self.haematologyTestmatch = items
                case "Biochemistry":
                    self.biochemistryTestmatch = items
                case "Serology":
                    self.serologyTestmatch = items
                case "Microbiology":
                    self.microbiologyTestmatch = items
                case "Others":
                    self.othersTestmatch = items
                default:
                    self.testmatch = items
                }
            }
        } catch {
            print("Failed to fetch items: \(error.localizedDescription)")
        }
    }
        
    func fetchTestmatchSubLastBatches(withSub sub: String, MaxBatch maxBatch: Int16) {
        let minBatch = maxBatch > 2 ? maxBatch - 2 : 1
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<Testmatch> = Testmatch.fetchRequest()
        let subPredicate = NSPredicate(format: "sub == %@", sub)
        let minBatchPredicate = NSPredicate(format: "batch >= %i", minBatch)
        let maxBatchPredicate = NSPredicate(format: "batch <= %i", maxBatch)
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [subPredicate, minBatchPredicate, maxBatchPredicate])
        fetchRequest.predicate = compoundPredicate
        
        do {
            let items = try context.fetch(fetchRequest)
            DispatchQueue.main.async {
                self.testmatch = items
            }
        } catch {
            print("Failed to fetch items: \(error.localizedDescription)")
        }
    }
    
    func addTestmatch(withName main: String, sub: String, result: String, batch: Int16) {
        let context = PersistenceController.shared.container.viewContext
        let testmatch = Testmatch(context: context)
        testmatch.id = UUID()
        testmatch.main = main
        testmatch.sub = sub
        testmatch.result = result
        testmatch.batch = batch
        do {
            print("Testmatch: \(testmatch.sub ?? "No name")")
            try context.save()
        } catch {
            print("Failed to save item: \(error.localizedDescription)")
        }
    }
    
    func deleteTestmatch(withBatch batch: Int16) {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<Testmatch> = Testmatch.fetchRequest()
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
    
    func deleteTestmatches() {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<Testmatch> = Testmatch.fetchRequest()
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
