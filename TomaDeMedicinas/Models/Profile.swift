//
//  Profile.swift
//  TomaDeMedicinas
//
//  Created by Gloria Saona Vázquez  on 1/12/21.
//

import Foundation

struct Profile: Equatable, Codable, Comparable {
    let id = UUID()
    var name: String
    
    static func ==(lhs: Profile, rhs: Profile) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func <(lhs: Profile, rhs: Profile) -> Bool {
        return lhs.name < rhs.name
    }
}

var profiles: [Profile] = [Profile(name: NSUserName())]
