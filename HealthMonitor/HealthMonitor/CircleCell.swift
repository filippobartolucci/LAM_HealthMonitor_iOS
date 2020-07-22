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
    let days : [Date]
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
    @Binding var reports : [Report]
    var report : Report?
    
    var body: some View {
        Group{
            ZStack {
                HStack{
                    if (self.searchReport(d: self.date) == -1){
                        
                            ZStack{
                                if (self.date == self.days[self.days.count - 1]){
                                    Circle()
                                        .stroke(Color.blue,lineWidth: 5)
                                        .opacity(1)
                                        .scaledToFit()
                                    
                                }else{
                                    Circle()
                                        .stroke(Color.gray,lineWidth: 5)
                                        .opacity(self.calcOpacity(days: self.days, day: self.date))
                                        .scaledToFit()
                                }
                                Text(String(self.date.get(.day)))
                                    .foregroundColor(.primary)
                                    .font(.system(size: 20))
                                    .offset(y: 3)
                                Text(monthName[self.date.get(.month)]!)
                                    .foregroundColor(.primary)
                                    .offset(y:-15)
                                    .font(.system(size: 15))
                            }
                            .layoutPriority(100)
                        
                    }else{
                        NavigationLink(destination: ReportDetail(reports: self.$reports, report : reports[self.searchReport(d: self.date)])) {
                            ZStack{
                                if (self.date == self.days[self.days.count - 1]){
                                    Circle()
                                        .stroke(Color.blue,lineWidth: 5)
                                        .opacity(1)
                                        .scaledToFit()
                                    
                                }else{
                                    Circle()
                                        .stroke(Color.gray,lineWidth: 5)
                                        .opacity(self.calcOpacity(days: self.days, day: self.date))
                                        .scaledToFit()
                                }
                                Text(String(self.date.get(.day)))
                                    .foregroundColor(.primary)
                                    .font(.system(size: 20))
                                    .offset(y: 3)
                                Text(monthName[self.date.get(.month)]!)
                                    .foregroundColor(.primary)
                                    .offset(y:-15)
                                    .font(.system(size: 15))
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
    
    private func calcOpacity(days : [Date], day: Date) -> Double{
        let index = days.firstIndex(of: day)!
        return (Double(index+1))/Double(days.count)
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
