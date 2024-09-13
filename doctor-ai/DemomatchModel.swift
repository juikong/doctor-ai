//
//  DemomatchModel.swift
//  doctor-ai
//
//  Created by Juiko Ong on 26/07/2024.
//

import SwiftUI
import CoreData

class DemomatchModel: ObservableObject {
    @Published var demomatch: [Demomatch] = []
    @Published var haematologyDemomatch: [Demomatch] = []
    @Published var biochemistryDemomatch: [Demomatch] = []
    @Published var serologyDemomatch: [Demomatch] = []
    @Published var microbiologyDemomatch: [Demomatch] = []
    
    func fetchDemomatch() {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<Demomatch> = Demomatch.fetchRequest()
        
        do {
            let items = try context.fetch(fetchRequest)
            DispatchQueue.main.async {
                self.demomatch = items
            }
        } catch {
            print("Failed to fetch items: \(error.localizedDescription)")
        }
    }
        
    func fetchDemomatchMain(withMain main: String) {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<Demomatch> = Demomatch.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "main == %@", main)
        
        do {
            let items = try context.fetch(fetchRequest)
            DispatchQueue.main.async {
                self.demomatch = items
            }
        } catch {
            print("Failed to fetch items: \(error.localizedDescription)")
        }
    }

    func fetchDemomatchSub(withSub sub: String) {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<Demomatch> = Demomatch.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "sub == %@", sub)
        
        do {
            let items = try context.fetch(fetchRequest)
            DispatchQueue.main.async {
                self.demomatch = items
            }
        } catch {
            print("Failed to fetch items: \(error.localizedDescription)")
        }
    }
    
    func fetchDemomatchBatch(withBatch batch: Int16) {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<Demomatch> = Demomatch.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "batch == %i", batch)
        
        do {
            let items = try context.fetch(fetchRequest)
            DispatchQueue.main.async {
                self.demomatch = items
            }
        } catch {
            print("Failed to fetch items: \(error.localizedDescription)")
        }
    }
    
    func fetchDemomatchMainBatch(withMain main: String, Batch batch: Int16) {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<Demomatch> = Demomatch.fetchRequest()
        let mainPredicate = NSPredicate(format: "main == %@", main)
        let batchPredicate = NSPredicate(format: "batch == %i", batch)
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [mainPredicate, batchPredicate])
        fetchRequest.predicate = compoundPredicate
        
        do {
            let items = try context.fetch(fetchRequest)
            DispatchQueue.main.async {
                switch main {
                case "Haematology":
                    self.haematologyDemomatch = items
                case "Biochemistry":
                    self.biochemistryDemomatch = items
                case "Serology":
                    self.serologyDemomatch = items
                case "Microbiology":
                    self.microbiologyDemomatch = items
                default:
                    self.demomatch = items
                }
            }
        } catch {
            print("Failed to fetch items: \(error.localizedDescription)")
        }
    }
    
    func fetchDemomatchSubLastBatches(withSub sub: String, MaxBatch maxBatch: Int16) {
        //let minBatch = maxBatch > 2 ? maxBatch - 2 : 1
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<Demomatch> = Demomatch.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "sub == %@", sub)
        //let subPredicate = NSPredicate(format: "sub == %@", sub)
        //let minBatchPredicate = NSPredicate(format: "batch >= %i", minBatch)
        //let maxBatchPredicate = NSPredicate(format: "batch <= %i", maxBatch)
        //let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [subPredicate, minBatchPredicate, maxBatchPredicate])
        //fetchRequest.predicate = compoundPredicate
        
        do {
            let items = try context.fetch(fetchRequest)
            DispatchQueue.main.async {
                self.demomatch = items
            }
        } catch {
            print("Failed to fetch items: \(error.localizedDescription)")
        }
    }
    
    func addDemomatch(withName main: String, sub: String, result: String, batch: Int16) {
        let context = PersistenceController.shared.container.viewContext
        let demomatch = Demomatch(context: context)
        demomatch.id = UUID()
        demomatch.main = main
        demomatch.sub = sub
        demomatch.result = result
        demomatch.batch = batch
        do {
            print("Demomatch: \(demomatch.sub ?? "No name")")
            try context.save()
        } catch {
            print("Failed to save item: \(error.localizedDescription)")
        }
    }
    
    func deleteDemomatches() {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<Demomatch> = Demomatch.fetchRequest()
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
