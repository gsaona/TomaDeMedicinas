//
//  Medication.swift
//  TomaDeMedicinas
//
//  Created by Gloria Saona Vázquez  on 17/11/21.
//

import Foundation

struct Medication: Codable {
    let id = UUID()
    var name: String
}

extension Medication: Hashable { }
