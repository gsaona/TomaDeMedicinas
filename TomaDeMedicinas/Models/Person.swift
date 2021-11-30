//
//  Person.swift
//  TomaDeMedicinas
//
//  Created by Gloria Saona Vázquez  on 17/11/21.
//

import Foundation

struct Person: Codable {
    let id = UUID()
    var relation: String?
    var takingMedications: [Taking]?
}

extension Person: Hashable { }

extension Person: Comparable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        func compareIDs(_ l: Person, _ r: Person) -> Bool {
            switch (l.id, r.id) {
            case (let l, let r):
                return l == r
            case (nil, .some(_)):
                return false
            case (.some(_), nil):
                return true
            case (nil, nil):
                return lhs.id.uuidString < rhs.id.uuidString
            }
        }
        
        switch (lhs.takingMedications, rhs.takingMedications) {
        case (let l?, let r?):
            let result = Calendar.current.compare(l.dueDate, to: r.dueDate, toGranularity: .day)
            if result == .orderedSame {
                return compareIDs(lhs, rhs)
            } else {
                return result == .orderedAscending
            }
        case (nil, .some(_)):
            return false
        case (.some(_), nil):
            return true
        case (nil, nil):
            return compareAmounts(lhs, rhs)
        }
    }
