//
//  CalendarCell.swift
//  HealthMonitor
//
//  Created by Filippo Bartolucci on 14/07/2020.
//  Copyright © 2020 Filippo Bartolucci. All rights reserved.
//

import SwiftUI

struct MyCalendarCell: View {
    var reports : [Report]
    var days : [Date]
    var day : Date
    
    
    var body: some View {
        
        HStack{
            if(self.days[self.days.count-1]==self.day ? true : false){
                ZStack{
                    Circle()
                        .fill(Color.red)
                        .scaledToFit()
                        .opacity(0.5)
                        .frame(height: 30)
                    (Text(String(day.get(.day))))
                }
                
            }else{
                (Text(String(day.get(.day))))
            }
        }
    }
}
