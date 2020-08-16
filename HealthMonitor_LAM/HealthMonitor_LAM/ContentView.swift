//
//  ContentView.swift
//  HealthMonitor_LAM
//
//  Created by Filippo Bartolucci on 12/08/2020.
//  Copyright © 2020 Filippo Bartolucci. All rights reserved.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    //    MARK: -CoreData Setup
    // CoreData enviroment
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        entity: Report.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Report.date, ascending: false)
        ]
    ) var reports: FetchedResults<Report>
    
    var filteredReport = [Report]()
    
    //    MARK: -View
    var body: some View {
        TabView(){
            if (self.reports.isEmpty){
                Tab1NoReportView(reports: self.reports).tabItem {
                    HStack{
                        Image(systemName: "heart.fill").font(.system(size: 24.0))
                        Text("Summary")
                    }
                }
            }else{
                Tab1View(reports:self.reports).environment(\.managedObjectContext, managedObjectContext).tabItem {
                    HStack{
                        Image(systemName: "heart.fill").font(.system(size: 24.0))
                        Text("Summary")
                    }
                }
            }
            
            Tab2View(reports:self.reports).environment(\.managedObjectContext, managedObjectContext).tabItem {
                HStack{
                    Image(systemName: "square.grid.2x2.fill").font(.system(size: 24.0))
                    Text("Other")
                }
            }
        }
        .accentColor(.red)
    }
}


