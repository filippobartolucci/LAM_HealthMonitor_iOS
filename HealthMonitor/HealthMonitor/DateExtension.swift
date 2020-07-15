//
//  DateExtension.swift
//  HealthMonitor
//
//  Created by Filippo Bartolucci on 15/07/2020.
//  Copyright © 2020 Filippo Bartolucci. All rights reserved.
//

import Foundation
import SwiftUI


// MARK: -Date type extensions
extension Date: Identifiable {
    // Identifiable
    public var id: Date { self }
    
    // Array of days between two dates
    static func dates(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate

        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
    
    // Get separated components of a date
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}