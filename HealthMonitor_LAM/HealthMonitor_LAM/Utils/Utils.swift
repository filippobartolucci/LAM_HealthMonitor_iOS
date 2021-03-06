//
//  Utils.swift
//  HealthMonitor_LAM
//
//  Created by Filippo Bartolucci on 13/08/2020.
//  Copyright © 2020 Filippo Bartolucci. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData

// true if date1 and date2 are the same excluding the time
func compareDate(date1:Date, date2:Date) -> Bool {
    let order = NSCalendar.current.compare(date1, to: date2, toGranularity: .day)
    switch order {
    case .orderedSame:
        return true
    default:
        return false
    }
}

func daysBetween(firstDate : Date, secondDate: Date) -> Int{
    let calendar = Calendar.current

    // Replace the hour (time) of both dates with 00:00
    let date1 = calendar.startOfDay(for: firstDate)
    let date2 = calendar.startOfDay(for: secondDate)

    return calendar.dateComponents([.day], from: date1, to: date2).day!
}

// create an array of a value for graph
func createTemperatureArray(reports: FetchedResults<Report>) -> [Double] {
    var array = [Double]()
    for report in reports.reversed(){
        array.append(Double(report.temperature))
    }
    return array
}
func createWeightArray(reports: FetchedResults<Report>) -> [Double] {
    var array = [Double]()
    for report in reports.reversed(){
        array.append(Double(report.weight))
    }
    return array
}
func createHeartArray(reports: FetchedResults<Report>) -> [Double] {
    var array = [Double]()
    for report in reports.reversed(){
        array.append(Double(report.heartRate))
    }
    return array
}
func createGlycemiaArray(reports: FetchedResults<Report>) -> [Double] {
    var array = [Double]()
    for report in reports.reversed(){
        array.append(Double(report.glycemia))
    }
    return array
}


// Create avg value for monitoring
func avgMonitoringValue(m: Monitoring, rs: FetchedResults<Report>) -> Float{
    var sum = Float(0)
    var counter = 0
    
    // a report r is used for avg only if:
    // - m.startDay < r.date
    // - m.importance <= r.value.importance
    
    if m.value! == "Temp" {
        for r in rs{
            if (m.importance <= r.temperatureImportance && m.startDay ?? Date() < r.date ?? Date()){
                sum += r.temperature
                counter += 1
            }
        }
    }
        
    if m.value! == "Weight" {
        for r in rs{
            if (m.importance <= r.temperatureImportance && m.startDay ?? Date() < r.date ?? Date()){
                sum += r.temperature
                counter += 1
            }
        }
    }
        
    if m.value!  == "Hear Rate"{
        for r in rs{
            if (m.importance <= r.temperatureImportance && m.startDay ?? Date() < r.date ?? Date()){
                sum += r.temperature
                counter += 1
            }
        }
        
    }
        
    if m.value! == "Glycemia"{
        for r in rs{
            if (m.importance <= r.temperatureImportance && m.startDay ?? Date() < r.date ?? Date()){
                sum += r.temperature
                counter += 1
            }
        }
    }
    
    if counter == 0{
        return 0
    }
    
    return Float((sum)/Float(counter))
}

// View used as header for section view
struct sectionText: View {
    var text : String
    
    var body : some View {
        Group{
            HStack{Text(text);Spacer()}.frame(maxWidth: widthBound)
        }
    }
}

// Divider with width bound
struct myDivider: View {
    var body : some View {
        Divider().frame(maxWidth: widthBound)
    }
}


