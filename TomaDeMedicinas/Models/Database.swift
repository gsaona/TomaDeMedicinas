//
//  Database.swift
//  TomaDeMedicinas
//
//  Created by Gloria Saona Vázquez  on 9/12/21.
//

import Foundation
import UIKit

class Database {
    
    static let takeUpdatedNotification = NSNotification.Name("gloria.TomaDeMedicinas.takeUpdated")
    
//    enum pathComponents: String {
//        case takeOfMedicines
//        case patternOfMedicines
//    }
    
    static let shared = Database()
    
    static func loadTakeData() -> [UUID:Take]? {
        var takes = [UUID:Take]()
        do {
            let storageDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let storageURL = storageDirectory.appendingPathComponent("takeOfMedicines").appendingPathExtension("json")
            let fileData = try Data(contentsOf: storageURL)
            let takesArray = try JSONDecoder().decode([Take].self, from: fileData)
            takes = takesArray.reduce(into: takes) {
                partial, take in
                partial[take.id] = take
            }
        } catch { return nil }
        return takes
    }
    
    static func saveTakeData(_ takes: [UUID:Take]) {
        do {
            let storageDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let storageURL = storageDirectory.appendingPathComponent("takeOfMedicines").appendingPathExtension("json")
            let fileData = try JSONEncoder().encode(Array(takes.values))
            try fileData.write(to: storageURL)
        } catch {
            fatalError("Ha habido un probelma guardando las tomas. Error: \(error)")
        }
    }
    
    private var takesOptional: [UUID:Take]?
    private var takesLookup: [UUID:Take] {
        get {
            if takesOptional == nil { takesOptional = Database.loadTakeData() ?? [:] }
            return takesOptional!
        }
        set {
            takesOptional = newValue
        }
    }
    
    var takes: [Take] {
        get { return Array(takesLookup.values) }
//        .sorted(by: <))}
    }
    
    func addTake() -> Take {
        let newTake = Take()
        takesLookup[newTake.id] = newTake
        return newTake
    }
    
    func updateAndSave(_ take: Take) {
        takesLookup[take.id] = take
        save()
        NotificationCenter.default.post(name: Self.takeUpdatedNotification, object: nil)
    }
    
    func save() {
        Database.saveTakeData(takesLookup)
    }
    
    func delete(take: Take) {
        takesLookup[take.id] = nil
    }
    
    func getTake(withID id: UUID) -> Take? {
        return takesLookup[id]
    }
    
    
}
