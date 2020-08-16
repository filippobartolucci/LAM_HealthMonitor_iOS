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
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: Report.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Report.date, ascending: false)]
    ) var reports: FetchedResults<Report>
    
    //    MARK: -View
    var body: some View {
        TabView(){
            Tab1View(reports: self.reports).tabItem {
                HStack{
                    Image(systemName: "heart.fill").font(.system(size: tabIconSize))
                    Text("Summary")
                }
            }
            Tab2View(reports:self.reports).environment(\.managedObjectContext, managedObjectContext).tabItem {
                HStack{
                    Image(systemName: "square.grid.2x2.fill").font(.system(size: tabIconSize))
                    Text("Other")
                }
            }
        }
        .accentColor(.red)
    }
}


