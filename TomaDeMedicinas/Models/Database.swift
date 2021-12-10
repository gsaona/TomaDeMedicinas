//
//  Database.swift
//  TomaDeMedicinas
//
//  Created by Gloria Saona Vázquez  on 9/12/21.
//

import Foundation
import UIKit

class Database {
    
    static let takingUpdatedNotification = NSNotification.Name("gloria.TomaDeMedicinas.takingUpdated")

    static let shared = Database()
    
    static func loadData() -> [UUID:Taking]? {
        var takings = [UUID:Taking]()
        do {
            let storageDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let storageURL = storageDirectory.appendingPathComponent("takingOfMedicines").appendingPathExtension("json")
            let fileData = try Data(contentsOf: storageURL)
            let takingsArray = try JSONDecoder().decode([Taking].self, from: fileData)
            takings = takingsArray.reduce(into: takings) {
                partial, taking in
                partial[taking.id] = taking
            }
        } catch { return nil }
        return takings
    }
    
    static func saveData(_ takings: [UUID:Taking]) {
        do {
            let storageDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let storageURL = storageDirectory.appendingPathComponent("takingOfMedicines").appendingPathExtension("json")
            let fileData = try JSONEncoder().encode(Array(takings.values))
            try fileData.write(to: storageURL)
        } catch {
            fatalError("Ha habido un probelma guardando las tomas. Error: \(error)")
        }
    }
    
    private var takingsOptional: [UUID:Taking]?
    private var takingsLookup: [UUID:Taking] {
        get {
            if takingsOptional == nil { takingsOptional = Database.loadData() ?? [:] }
            return takingsOptional!
        }
        set {
            takingsOptional = newValue
        }
    }
    
    var takings: [Taking] {
        get { return Array(takingsLookup.values.sorted(by: <))}
    }
    
    func addTaking() -> Taking {
        let taking = Taking()
        takingsLookup[taking.id] = taking
        return taking
    }
    
    func updateAndSave(_ taking: Taking) {
        takingsLookup[taking.id] = taking
        save()
        NotificationCenter.default.post(name: Self.takingUpdatedNotification, object: nil)
    }
    
    func save() {
        Database.saveData(takingsLookup)
    }
    
    func delete(taking: Taking) {
        takingsLookup[taking.id] = nil
    }
    
    func getTaking(withID id: UUID) -> Taking? {
        return takingsLookup[id]
    }
    
    
}
