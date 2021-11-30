//
//  Taking.swift
//  TomaDeMedicinas
//
//  Created by Gloria Saona Vázquez  on 17/11/21.
//

import Foundation

struct Taking: Codable {
    let id = UUID()
    var dueDate: Date
    var medication: Medication
}

extension Taking: Hashable { }

extension Taking {
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    var formattedDueDate: String {
        let dateString: String
        
        dateString = Taking.dateFormatter.string(from: dueDate)
        
        return dateString
    }
}
