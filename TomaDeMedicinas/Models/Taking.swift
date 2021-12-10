//
//  Database.swift
//  TomaDeMedicinas
//
//  Created by Gloria Saona Vázquez  on 17/11/21.
//

import Foundation
import UIKit

struct Taking: Equatable, Codable, Comparable {
    let id = UUID()
    var profile: String?
    var medicationName: String?
    var date: Date?
    var hour: String?
    var quantity: Double?
    var unitOfQuantity: String?
    
    static func ==(lhs: Taking, rhs: Taking) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func <(lhs: Taking, rhs: Taking) -> Bool {
        return lhs.date! < rhs.date!
    }
    
    static func sampleTaking() -> [Taking] {
        let oneDayIntervalInSeconds: Double = 86400
        return [Taking(profile: profiles[0].name, medicationName: medicationNames[0].name, date: Date.now, hour: "21:00", quantity: 0.5, unitOfQuantity: "pastilla"),
                Taking(profile: profiles[0].name, medicationName: medicationNames[0].name, date: Date.now.addingTimeInterval(oneDayIntervalInSeconds), hour: "21:00", quantity: 0.75, unitOfQuantity: "pastilla"),
                Taking(profile: profiles[0].name, medicationName: medicationNames[0].name, date: Date.now.addingTimeInterval(2 * oneDayIntervalInSeconds), hour: "21:00", quantity: 0.75, unitOfQuantity: "pastilla"),
                Taking(profile: profiles[0].name, medicationName: medicationNames[0].name, date: Date.now.addingTimeInterval(3 * oneDayIntervalInSeconds), hour: "21:00", quantity: 0.5, unitOfQuantity: "pastilla"),
                Taking(profile: profiles[0].name, medicationName: medicationNames[1].name, date: Date.now, hour: "21:00", quantity: 1.5, unitOfQuantity: "pastilla"),
                Taking(profile: profiles[0].name, medicationName: medicationNames[1].name, date: Date.now.addingTimeInterval(oneDayIntervalInSeconds), hour: "21:00", quantity: 1.5, unitOfQuantity: "pastilla"),
                Taking(profile: profiles[0].name, medicationName: medicationNames[1].name, date: Date.now.addingTimeInterval(2 * oneDayIntervalInSeconds), hour: "21:00", quantity: 1.5, unitOfQuantity: "pastilla"),
                Taking(profile: profiles[0].name, medicationName: medicationNames[1].name, date: Date.now.addingTimeInterval(3 * oneDayIntervalInSeconds), hour: "21:00", quantity: 1.5, unitOfQuantity: "pastilla"),
                Taking(profile: profiles[0].name, medicationName: medicationNames[1].name, date: Date.now.addingTimeInterval(4 * oneDayIntervalInSeconds), hour: "21:00", quantity: 1.5, unitOfQuantity: "pastilla")
               ]
    }
}

extension Taking {
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    var formattedTakingDate: String {
        return Taking.dateFormatter.string(from: self.date!)
    }
}

extension Taking: Hashable {
    
}

//var items: [TakingsOfMedication] = []
