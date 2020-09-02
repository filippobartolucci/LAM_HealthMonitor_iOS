//
//  Utils.swift
//  HealthMonitor_LAM
//
//  Created by Filippo Bartolucci on 13/08/2020.
//  Copyright © 2020 Filippo Bartolucci. All rights reserved.
//

import Foundation
import SwiftUI


func compareDate(date1:Date, date2:Date) -> Bool {
    let order = NSCalendar.current.compare(date1, to: date2, toGranularity: .day)
    switch order {
    case .orderedSame:
        return true
    default:
        return false
    }
}

struct sectionText: View {
    var text : String
    
    var body : some View {
        Group{
            HStack{Text(text);Spacer()}.frame(maxWidth: widthBound)
        }
    }
}
