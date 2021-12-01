//
//  Profile.swift
//  TomaDeMedicinas
//
//  Created by Gloria Saona Vázquez  on 1/12/21.
//

import Foundation

struct Profile: Equatable, Codable {
    let id = UUID()
    var name: String
    
    static func ==(lhs: Profile, rhs: Profile) -> Bool {
        return lhs.id == rhs.id
    }
}

var profiles: [Profile] = [Profile(name: "gloria")]

