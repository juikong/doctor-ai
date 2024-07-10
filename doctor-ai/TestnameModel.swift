//
//  TestnameModel.swift
//  doctor-ai
//
//  Created by Juiko Ong on 06/07/2024.
//

import SwiftUI
import CoreData

class TestnameModel: ObservableObject {
    @Published var testname: [Testname] = []
    @Published var haematologyTestname: [Testname] = []
    @Published var biochemistryTestname: [Testname] = []
    @Published var serologyTestname: [Testname] = []
    @Published var microbiologyTestname: [Testname] = []
    
    func fetchTestnames() {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<Testname> = Testname.fetchRequest()
        //fetchRequest.predicate = NSPredicate(format: "active == true")
        
        do {
            let items = try context.fetch(fetchRequest)
            DispatchQueue.main.async {
                self.testname = items
            }
        } catch {
            print("Failed to fetch items: \(error.localizedDescription)")
        }
    }
    
    func fetchHaematology() {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<Testname> = Testname.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "main == %@", "Haematology")
        
        do {
            let items = try context.fetch(fetchRequest)
            DispatchQueue.main.async {
                self.haematologyTestname = items
            }
        } catch {
            print("Failed to fetch items: \(error.localizedDescription)")
        }
    }
    
    func fetchBiochemistry() {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<Testname> = Testname.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "main == %@", "Biochemistry")
        
        do {
            let items = try context.fetch(fetchRequest)
            DispatchQueue.main.async {
                self.biochemistryTestname = items
            }
        } catch {
            print("Failed to fetch items: \(error.localizedDescription)")
        }
    }
    
    func fetchSerology() {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<Testname> = Testname.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "main == %@", "Serology")
        
        do {
            let items = try context.fetch(fetchRequest)
            DispatchQueue.main.async {
                self.serologyTestname = items
            }
        } catch {
            print("Failed to fetch items: \(error.localizedDescription)")
        }
    }
    
    func fetchMicrobiology() {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<Testname> = Testname.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "main == %@", "Microbiology")
        
        do {
            let items = try context.fetch(fetchRequest)
            DispatchQueue.main.async {
                self.microbiologyTestname = items
            }
        } catch {
            print("Failed to fetch items: \(error.localizedDescription)")
        }
    }
    
    func addTestname(withMain main: String, sub: String, revision: Int16) {
        let context = PersistenceController.shared.container.viewContext
        let testname = Testname(context: context)
        testname.id = UUID()
        testname.main = main
        testname.sub = sub
        testname.revision = revision
        do {
            print("Testname: \(testname.sub ?? "No name")")
            try context.save()
        } catch {
            print("Failed to save item: \(error.localizedDescription)")
        }
    }
}
