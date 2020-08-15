//
//  LinearCalendar.swift
//  HealthMonitor
//
//  Created by Filippo Bartolucci on 15/07/2020.
//  Copyright © 2020 Filippo Bartolucci. All rights reserved.
//

import SwiftUI


struct CircleCell: View {
    let date : Date
    @Binding var reports : [Report]
    
    var body: some View {
        Group{
            ZStack {
                HStack{
                    if (self.searchReport(d: self.date) == -1){
                            ZStack{
                                cellBackground()
                                cellText(date: self.date)
                            }
                            .layoutPriority(100)
                        
                    }else{
                        NavigationLink(destination: ReportDetail(reports: self.$reports, report : reports[self.searchReport(d: self.date)])) {
                            ZStack{
                                cellBackground()
                                cellText(date: self.date)
                                // Red dot to notify that there is a report
                                Text(" ")
                                    .frame(width: 7, height: 7)
                                    .background(Color(.red))
                                    .opacity(0.9)
                                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                                    .offset(y:20)
                            }
                            .layoutPriority(100)
                        }
                    }
                    
                }
            }
        }
    }
    
    private func searchReport(d : Date) -> Int{
        for r in self.reports {
            if compareDate(date1: d, date2: r.date){
                return self.reports.firstIndex(of: r)!
            }
        }
        return -1
    }
    
    private func compareDate(date1:Date, date2:Date) -> Bool {
        let order = NSCalendar.current.compare(date1, to: date2, toGranularity: .day)
        switch order {
        case .orderedSame:
            return true
        default:
            return false
        }
    }
}


struct cellBackground : View {
    @Environment(\.colorScheme) var colorScheme
    var body : some View{
        Text("").frame(width: 70, height: 70)
        .background(colorScheme == .dark ? Color.black : Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 7, x: 0, y: 2)
    }
}

struct cellText : View {
    var date : Date
    let monthName: [Int : String] = [
        1 : "Jan",
        2 : "Feb",
        3 : "Mar",
        4 : "Apr",
        5 : "May",
        6 : "Jun",
        7 : "Jul",
        8 : "Aug",
        9 : "Set",
        10 : "Oct",
        11 : "Nov",
        12 : "Dec",
    ]
    var body : some View {
        Group{
            Text(String(self.date.get(.day)))
                .foregroundColor(.primary)
                .font(.system(size: 20))
                .offset(y: 3)
            Text(monthName[self.date.get(.month)]!)
                .foregroundColor(.primary)
                .offset(y:-15)
                .font(.system(size: 15))
        }
    }
}
