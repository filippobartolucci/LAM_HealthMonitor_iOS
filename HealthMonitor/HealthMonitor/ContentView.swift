//
//  ContentView.swift
//  HealthMonitor
//
//  Created by Filippo Bartolucci on 12/07/2020.
//  Copyright © 2020 Filippo Bartolucci. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var addingReport = false
    @State var reports = reportExample()
    
    var body: some View {
        NavigationView {
            
            List(reports){report in
                NavigationLink(destination: ReportDetail(reports: self.$reports, report : report)) {
                    ReportRow(report : report)
                }
            }
           
            .navigationBarTitle(Text("Healt Monitor"), displayMode: .inline)
            .navigationBarItems(trailing:Button(action: {
                self.addingReport.toggle()
            }) {Image(systemName: "plus")})
            
            .sheet(isPresented: $addingReport) {
                AddReport(addingReport: self.$addingReport, temp: "0")
            }
        }
    }
    
    
    static func reportExample() -> [Report] {
      let r1 = Report(date : Date(timeIntervalSince1970: 1056535641), temperature: 37.5)
      let r2 = Report(date : Date(), temperature: 36.0)
      return [r1, r2, r1]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
           ContentView().environment(\.colorScheme, .light)
           //ContentView().environment(\.colorScheme, .dark)
        }

    }
}
