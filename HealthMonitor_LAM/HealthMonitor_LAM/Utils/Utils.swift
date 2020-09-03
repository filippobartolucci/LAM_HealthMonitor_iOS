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

func compareDate(date1:Date, date2:Date) -> Bool {
    let order = NSCalendar.current.compare(date1, to: date2, toGranularity: .day)
    switch order {
    case .orderedSame:
        return true
    default:
        return false
    }
}

func avgMonitoringValue(m: Monitoring, rs: FetchedResults<Report>) -> Float{
    var sum = Float(0)
    var counter = 0
    
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

struct sectionText: View {
    var text : String
    
    var body : some View {
        Group{
            HStack{Text(text);Spacer()}.frame(maxWidth: widthBound)
        }
    }
}

struct myDivider: View {
    var body : some View {
        Divider().frame(maxWidth: widthBound)
    }
}


