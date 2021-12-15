//
//  Database.swift
//  TomaDeMedicinas
//
//  Created by Gloria Saona Vázquez  on 17/11/21.
//

import Foundation
import UIKit

struct Take: Equatable, Codable, Comparable {
    let id = UUID()
    var profile: String?
    var medicationName: String?
    var dateTime: Date?
    var quantity: Double?
    var unitOfQuantity: String?
    
    
    static func ==(lhs: Take, rhs: Take) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func <(lhs: Take, rhs: Take) -> Bool {
        return lhs.dateTime! < rhs.dateTime!
    }
}

extension Take {
   
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    private static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
    
    var formattedTakeDate: String {
        return Take.dateFormatter.string(from: self.dateTime!)
    }
    
    var formattedTakeTime: String {
        return Take.timeFormatter.string(from: self.dateTime!)
    }
}

extension Take: Hashable {
    
}
