//
//  Database.swift
//  TomaDeMedicinas
//
//  Created by Gloria Saona Vázquez  on 17/11/21.
//

import Foundation
import UIKit

struct TakingsOfMedication: Equatable, Codable {
    let id = UUID()
    var profile: Profile
    var medicationName: Medication
    var date: String
    var hour: String
    var quantity: Double
    
    static func ==(lhs: TakingsOfMedication, rhs: TakingsOfMedication) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func sampleTaking() -> [TakingsOfMedication] {
        return [TakingsOfMedication(profile: profiles[0], medicationName: medicationNames[0], date: "30/11/2021", hour: "21:00", quantity: 0.5),
                TakingsOfMedication(profile: profiles[0], medicationName: medicationNames[0], date: "01/12/2021", hour: "21:00", quantity: 0.75),
                TakingsOfMedication(profile: profiles[0], medicationName: medicationNames[0], date: "02/12/2021", hour: "21:00", quantity: 0.75),
                TakingsOfMedication(profile: profiles[0], medicationName: medicationNames[0], date: "03/12/2021", hour: "21:00", quantity: 0.5),
                TakingsOfMedication(profile: profiles[0], medicationName: medicationNames[1], date: "30/11/2021", hour: "21:00", quantity: 1.5),
                TakingsOfMedication(profile: profiles[0], medicationName: medicationNames[1], date: "01/12/2021", hour: "21:00", quantity: 1.5),
                TakingsOfMedication(profile: profiles[0], medicationName: medicationNames[1], date: "02/12/2021", hour: "21:00", quantity: 1.5),
                TakingsOfMedication(profile: profiles[0], medicationName: medicationNames[1], date: "03/12/2021", hour: "21:00", quantity: 1.5),
                TakingsOfMedication(profile: profiles[0], medicationName: medicationNames[1], date: "04/12/2021", hour: "21:00", quantity: 1.5)
               ]
    }
    
    static func loadData() -> [TakingsOfMedication]? {
        var takingOfMedications = [TakingsOfMedication]()
        do {
            let storageDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let storageURL = storageDirectory.appendingPathComponent("takingOfMedicines").appendingPathExtension("json")
            let fileData = try Data(contentsOf: storageURL)
            let takingsArray = try JSONDecoder().decode([TakingsOfMedication].self, from: fileData)
            takingOfMedications = takingsArray
        } catch { return nil }
        return takingOfMedications
    }
    
    static func saveData(_ takings: [TakingsOfMedication]) {
        do {
            let storageDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let storageURL = storageDirectory.appendingPathComponent("takingOfMedicines").appendingPathExtension("json")
            let fileData = try JSONEncoder().encode(Array(takings))
            try fileData.write(to: storageURL)
        } catch {
            fatalError("Ha habido un probelma guardando las tomas. Error: \(error)")
        }
    }
}

var items: [TakingsOfMedication] = []
