//
//  ContentView.swift
//  HealthMonitor
//
//  Created by Filippo Bartolucci on 12/07/2020.
//  Copyright © 2020 Filippo Bartolucci. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    // @Binding is one of SwiftUI’s less used property wrappers, but it’s still hugely important: it lets us declare that one value actually comes from elsewhere, and should be shared in both places
    @State var addingReport = false
    
    var body: some View {
        NavigationView {
            //List{}
            Form {
                Section {
                    Text("Hello World")
                }
            }
            .navigationBarTitle(Text("Healt Monitor"), displayMode: .automatic)
            .navigationBarItems(trailing:Button(action: {
                self.addingReport.toggle()
            }) {Image(systemName: "plus")})
            .sheet(isPresented: $addingReport) {
                AddReport(addingReport: self.$addingReport, temp: "0")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
