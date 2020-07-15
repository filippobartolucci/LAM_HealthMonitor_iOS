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
        ZStack {
            HStack{
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
            }
        }

    }
    
    private func calcOpacity(days : [Date], day: Date) -> Double{
        let index = days.firstIndex(of: day)!
        return (Double(index+1))/Double(days.count)
    }
}
