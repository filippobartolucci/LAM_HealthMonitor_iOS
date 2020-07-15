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
    
    // Sheet
    @State var addingReport = false
    @State var showSheet = false
    
    @State var reports = reportExample()
    @State var days = Date.dates(from: Date().addingTimeInterval(-(60*60*24*10)), to: Date())
    
    var body: some View {
        NavigationView {
            VStack{
                if(self.reports.isEmpty){
                    Button(action: {
                        self.addingReport = true
                        self.showSheet.toggle()}) {
                        Text("Add first report")
                    }
                }else{
                    Form{
                        Section(header: Text("Calendar")){
                            ScrollView(.horizontal) {
                                HStack(spacing: 10) {
                                    ForEach(days.reversed()) { day in
                                        NavigationLink(destination: ReportDetail(reports: self.$reports, report: self.reports.last!)) {
                                            Group{
                                                CircleCell(date : day, days: self.days, reports: self.$reports, report : Report(date : Date(), temperature: 36.7, weight: 60))
                                                    .animation(.easeInOut)
                                                                                                }
                                        }
                                    }
                                }.padding()
                            }
                            .frame(width:UIScreen.main.bounds.size.width ,height: 100)
                            .offset(x : -20)
                        }
                        
                        Section{
                            NavigationLink(destination: ReportDetail(reports: self.$reports, report: self.reports.last!)) {
                                Text("Last report")
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
                self.addingReport = true
                self.showSheet.toggle()
            }) {Image(systemName: "plus")})
                
            .sheet(isPresented: $showSheet) {
                if (self.addingReport){
                    AddReport(addingReport: self.$showSheet, reports: self.$reports)
                }else {
                    Settings()
                }
            }
        }
    }
    
    static func reportExample() -> [Report] {
        let r1 = Report(date : Date(timeIntervalSince1970: 1256535641), temperature: 37.5, weight: 60)
        let r2 = Report(date : Date(timeIntervalSince1970: 1299984641), temperature: 36.0, weight: 60)
        let r3 = Report(date : Date(), temperature: 36.7, weight: 60)
        return [r1, r2, r3]
    }
    
    private func createTemperatureArray(reports : [Report]) -> [Double] {
        var array = [Double]()
        for report in reports{
            array.append(Double(report.temperature))
        }
        return array
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
