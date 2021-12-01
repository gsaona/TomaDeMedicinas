//
//  Medication.swift
//  TomaDeMedicinas
//
//  Created by Gloria Saona Vázquez  on 1/12/21.
//

import Foundation


struct Medication: Equatable, Codable {
    let id = UUID()
    var name: String
    
    static func ==(lhs: Medication, rhs: Medication) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Medication: Hashable {
    
}
var medicationNames: [Medication] = [Medication(name: "Sintrom"),
                                     Medication(name: "Trankimacin")]
