//
//  ContentView.swift
//  HealthMonitor
//
//  Created by Filippo Bartolucci on 12/07/2020.
//  Copyright © 2020 Filippo Bartolucci. All rights reserved.
//

import SwiftUI
import SwiftUICharts


struct ContentView: View {
    
    // Boolean var for modal
    @State var addingReport = false
    @State var showSheet = false
    @State var addToday = true
    @State var addDate = Date()
    
    // Report data
    @State var reports = reportExample()
    
    // Calendar days
    @State var days = Date.dates(from: Date().addingTimeInterval(-(60*60*24*9)), to: Date())
    
    var body: some View {
        NavigationView {
            VStack{
                if(self.reports.isEmpty){
                    // No report saved
                    Button(action: {
                        self.addingReport = true
                        self.showSheet.toggle()}) {
                            Text("Add first report")
                    }
                }else{
                    Form{
                        // Calendar
                        Section(header: Text("Calendar")){
                            ScrollView(.horizontal) {
                                HStack(spacing: 10) {
                                    ForEach(days.reversed()) { day in
                                        Button(action: {
                                            // Add report if there are no report
                                            self.addToday = false
                                            self.addDate = day
                                            self.addingReport = true
                                            self.showSheet.toggle()
                                        }, label: {
                                            // If there is a report, open report detail
                                            CircleCell(date : day, reports: self.$reports)
                                        })
                                    }
                                }.padding()
                            }
                            .frame(width:UIScreen.main.bounds.size.width ,height: 100)
                            .offset(x : -15)
                        }
                        
                        // Dashboard
                        Section(header: Text("Dashboard")){
                            // Dashboard
                            InfoCards(reports: self.reports)
                                .frame(width:UIScreen.main.bounds.size.width)
                                .offset(x:-15)
                            NavigationLink(destination: GraphView(reports: self.reports)) {
                                Text("Show graphs")
                            }
                        }
                        
                        // Reports
                        Section(header: Text("Last report")){
                            NavigationLink(destination: ReportDetail(reports: self.$reports, report : reports.last!)) {
                                ReportCard(report : reports.last!).padding(.vertical)
                            }
                            NavigationLink(destination: ReportList(reports: self.$reports)) {
                                Text("Show all reports")
                            }
                        }
                    }
                }
            }
                // MARK: -NavigationBar modifiers
                .navigationBarTitle(Text("Healt Monitor"), displayMode: .inline)
                .navigationBarItems( leading: Button(action: {
                    self.addingReport = false
                    self.showSheet.toggle()
                }) {Image(systemName: "gear")},trailing:Button(action: {
                    self.addToday = true
                    self.addingReport = true
                    self.showSheet.toggle()
                }) {Image(systemName: "plus")})
                
                // Sheet modal modifiers
                .sheet(isPresented: $showSheet) {
                    // Check which modal to open
                    if (self.addingReport){
                        if (self.addToday){
                            AddReport(addingReport: self.$showSheet, reports: self.$reports, date: Date())
                        }else{
                            AddReport(addingReport: self.$showSheet, reports: self.$reports, date: self.addDate)
                        }
                    }else {
                        Settings()
                    }
            }
        }
    }
    
    static func reportExample() -> [Report] {
        let r1 = Report(date : Date().dayBefore.dayBefore.dayBefore, temperature: 37.5, weight: 60,heartRate : 68)
        let r2 = Report(date : Date().dayBefore, temperature: 36.0, weight: 60,heartRate : 70)
        let r3 = Report(date : Date(), temperature: 36.7, weight: 60,heartRate : 78)
        return [r1, r2, r3]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().environment(\.colorScheme, .light)
            ContentView().environment(\.colorScheme, .dark)
        }
        
    }
}
