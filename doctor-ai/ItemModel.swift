//
//  ItemModel.swift
//  doctor-ai
//
//  Created by Juiko Ong on 06/07/2024.
//

import SwiftUI
import CoreData

class ItemModel: ObservableObject {
    @Published var items: [Item] = []
    @Published var revision: String = "2"
    @Published var lastbatch: String = "0"
    @Published var totalbatch: String = "0"
    
    func initRevision() {
        let context = PersistenceController.shared.container.viewContext
        let item = Item(context: context)
        item.id = 1
        item.parameter = "Revision"
        item.stringvalue = "2"
        do {
            try context.save()
        } catch {
            print("Failed to save item: \(error.localizedDescription)")
        }
    }

    func initLastBatch() {
        let context = PersistenceController.shared.container.viewContext
        let item = Item(context: context)
        item.id = 2
        item.parameter = "Last Batch"
        item.stringvalue = "0"
        do {
            try context.save()
        } catch {
            print("Failed to save item: \(error.localizedDescription)")
        }
    }
    
    func initTotalBatch() {
        let context = PersistenceController.shared.container.viewContext
        let item = Item(context: context)
        item.id = 3
        item.parameter = "Total Batch"
        item.stringvalue = "0"
        do {
            try context.save()
        } catch {
            print("Failed to save item: \(error.localizedDescription)")
        }
    }
    
    func fetchItem() {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        //fetchRequest.predicate = NSPredicate(format: "id == %i", 1)
        
        do {
            let items = try context.fetch(fetchRequest)
            DispatchQueue.main.async {
                self.items = items
            }
        } catch {
            print("Failed to fetch items: \(error.localizedDescription)")
        }
    }
    
    func fetchRevision() {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %i", 1)
        
        do {
            let items = try context.fetch(fetchRequest)
            if let parameterItem = items.first {
                self.revision = parameterItem.stringvalue ?? "2"
            } else {
                initRevision()
                print("Init Revision.")
            }
        } catch {
            print("Failed to fetch item: \(error.localizedDescription)")
        }
    }
    
    func fetchLastBatch() {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %i", 2)
        
        do {
            let items = try context.fetch(fetchRequest)
            if let parameterItem = items.first {
                self.lastbatch = parameterItem.stringvalue ?? "0"
            } else {
                initLastBatch()
                print("Init Last Batch.")
            }
        } catch {
            print("Failed to fetch item: \(error.localizedDescription)")
        }
    }
    
    func fetchTotalBatch() {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %i", 3)
        
        do {
            let items = try context.fetch(fetchRequest)
            if let parameterItem = items.first {
                self.totalbatch = parameterItem.stringvalue ?? "0"
            } else {
                initTotalBatch()
                print("Init Total Batch.")
            }
        } catch {
            print("Failed to fetch item: \(error.localizedDescription)")
        }
    }
    
    func updateItem(withId id: Int, newValue: Int) {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %i", id)
        
        do {
            let items = try context.fetch(fetchRequest)
            if let itemToUpdate = items.first {
                print("new batch")
                itemToUpdate.stringvalue = newValue.description
                try context.save()
            } else {
                print("Testname with ID \(id) not found.")
            }
        } catch {
            print("Failed to update item: \(error.localizedDescription)")
        }
    }
}
