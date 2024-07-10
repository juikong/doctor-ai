//
//  TestresultModel.swift
//  doctor-ai
//
//  Created by Juiko Ong on 06/07/2024.
//

import SwiftUI
import CoreData

class TestresultModel: ObservableObject {
    @Published var testresult: [Testresult] = []
    
    func fetchTestresults() {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<Testresult> = Testresult.fetchRequest()
        
        do {
            let items = try context.fetch(fetchRequest)
            DispatchQueue.main.async {
                self.testresult = items
            }
        } catch {
            print("Failed to fetch items: \(error.localizedDescription)")
        }
    }
    
    func addTestresult(withResult result: String, batch: Int16) {
        let context = PersistenceController.shared.container.viewContext
        let testresult = Testresult(context: context)
        testresult.id = UUID()
        testresult.result = result
        testresult.batch = batch
        do {
            print("Testresult: \(testresult.result ?? "No result")")
            try context.save()
        } catch {
            print("Failed to save item: \(error.localizedDescription)")
        }
    }
    
    func deleteTestresults() {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<Testresult> = Testresult.fetchRequest()
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
