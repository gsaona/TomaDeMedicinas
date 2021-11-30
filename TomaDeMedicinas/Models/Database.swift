//
//  Database.swift
//  TomaDeMedicinas
//
//  Created by Gloria Saona Vázquez  on 17/11/21.
//

import Foundation
import UIKit

class Database {
    
    static let takingMedicationUpdatedNotification = NSNotification.Name("gloria.TakingMedication.MedicationUpdated")

    static let shared = Database()
        
    private func loadPersons() -> [UUID:Person]? {
        var persons = [UUID:Person]()
        
        do {
            let storageDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let storageURL = storageDirectory.appendingPathComponent("personsMedication").appendingPathExtension("json")
            let fileData = try Data(contentsOf: storageURL)
            let personsArray = try JSONDecoder().decode([Person].self, from: fileData)
            persons = personsArray.reduce(into: persons) { partial, person in
                partial[person.id] = person
            }
        } catch {
            return nil
        }
        
        return persons
    }
    
    private func savePersonsMedication(_ persons: [UUID:Person]) {
        do {
            let storageDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let storageURL = storageDirectory.appendingPathComponent("personMedication").appendingPathExtension("json")
            let fileData = try JSONEncoder().encode(Array(persons.values))
            try fileData.write(to: storageURL)
        } catch {
            fatalError("There was a problem saving person Medication. Error: \(error)")
        }
    }
    
    private var _personsOptional: [UUID:Person]?
    private var _personsLookup: [UUID:Person] {
        get {
            if _personsOptional == nil {
                _personsOptional = loadPersons() ?? [:]
            }
            
            return _personsOptional!
        }
        set {
            _personsOptional = newValue
        }
    }
    
    var persons: [Person] {
        get {
            return Array(_personsLookup.values.sorted(by: <))
        }
    }
    
    func addBill() -> Bill {
        let bill = Bill()
        _billsLookup[bill.id] = bill
        return bill
    }
    
    func updateAndSave(_ bill: Bill) {
        _billsLookup[bill.id] = bill
        save()
        NotificationCenter.default.post(name: Self.billUpdatedNotification, object: nil)
    }
        
    func save() {
        saveBills(_billsLookup)
    }
    
    func delete(bill: Bill) {
        _billsLookup[bill.id] = nil
    }
    
    func getBill(withID id: UUID) -> Bill? {
        return _billsLookup[id]
    }
    
}

}
