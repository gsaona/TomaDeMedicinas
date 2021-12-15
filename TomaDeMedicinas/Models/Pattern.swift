//
//  Pattern.swift
//  TomaDeMedicinas
//
//  Created by Gloria Saona Vázquez  on 12/12/21.
//

import Foundation
import UIKit

struct Pattern: Equatable, Codable {
    
    let id = UUID()
    var takeDetails: Take
    var beginDateTime: Date
    var intervalOfDates: Int
    var intervalOfHours: Int
    
    static func ==(lhs: Pattern, rhs: Pattern) -> Bool {
        return lhs.id == rhs.id
    }
    
    func calculateCalendar() -> [Date] {
        var date = beginDateTime
        var dates: [Date] = []
         
        while Calendar.current.dateComponents([.day], from: beginDateTime, to: date).day! <= intervalOfDates - 1 {
            date = Calendar.current.date(byAdding: .hour, value: intervalOfHours, to: date)!
            dates.append(date)
        }
        return dates
    }
    
    func createTakings() -> [Take] {
        var take: Take = takeDetails
        var takes: [Take] = []
        let datesArray = calculateCalendar()
        
        for date in datesArray {
            take.dateTime = date
            takes.append(take)
        }
        return takes
    }
    
}
