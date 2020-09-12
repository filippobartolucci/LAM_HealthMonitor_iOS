//
//  Calendar.swift
//  HealthMonitor
//
//  Created by Filippo Bartolucci on 14/07/2020.
//  Copyright © 2020 Filippo Bartolucci. All rights reserved.
//

import SwiftUI
import QGrid

extension String: Identifiable{
    public var id: String { self }
}

// MARK: -Array shift extension
extension Array {
    func shift(withDistance distance: Int = 1) -> Array<Element> {
        let offsetIndex = distance >= 0 ?
            self.index(startIndex, offsetBy: distance, limitedBy: endIndex) :
            self.index(endIndex, offsetBy: distance, limitedBy: startIndex)

        guard let index = offsetIndex else { return self }
        return Array(self[index ..< endIndex] + self[startIndex ..< index])
    }
}

// MARK: -CalendarView object
struct CalendarView: View {
    @Binding var reports : [Report]
    @State var days = Date.dates(from: Date().addingTimeInterval(-(60*60*24*27)), to: Date())
    
    // MARK: -CalendarView Card Style
    var body: some View {
        ZStack{
            HStack{
                ZStack{
                    QGrid(self.nameOfDay.shift(withDistance: self.getTodayWeekDay()),columns: 7){
                        Text(String($0)).foregroundColor(.red)
                    }
                    Spacer()
                    QGrid(self.days, columns: 7, vSpacing: 20) {
                        MyCalendarCell(reports: self.reports, days: self.days, day: $0)
                    }
                    .offset(y : 35)
                }
                .layoutPriority(100)
                Spacer()
            }
            .frame(minWidth: UIScreen.main.bounds.size.width*0.85,maxHeight: 200)
            .padding()
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.2), lineWidth: 1)
        )
        .padding([.top, .horizontal])
    }
    
    // MARK: -Days of the week
    var nameOfDay = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]
    
    func getTodayWeekDay()-> Int{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.locale = Locale(identifier: "en_US")
        let weekDay = dateFormatter.string(from: Date())

        let dd: [String : Int] = [
            "Monday" : 0,
            "Tuesday" : 1,
            "Wednesday" : 2,
            "Thursday" : 3,
            "Friday" : 4,
            "Saturday" : 5,
            "Sunday" : 6
        ]
        return dd[weekDay]!+1
    }
}
