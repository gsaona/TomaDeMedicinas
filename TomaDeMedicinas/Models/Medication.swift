//
//  Medication.swift
//  TomaDeMedicinas
//
//  Created by Gloria Saona Vázquez  on 1/12/21.
//

import Foundation


struct Medication: Equatable, Codable, Comparable {
    let id = UUID()
    var name: String
    
    static func ==(lhs: Medication, rhs: Medication) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func <(lhs: Medication, rhs: Medication) -> Bool {
        return lhs.name < rhs.name
    }
}

extension Medication: Hashable {
    
}
var medicationNames: [Medication] = [Medication(name: "Sintrom"),
                                     Medication(name: "Trankimacin"),
                                     Medication(name: "Salbutamol")]
