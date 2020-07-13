//
//  AddReport.swift
//  HealthMonitor
//
//  Created by Filippo Bartolucci on 12/07/2020.
//  Copyright © 2020 Filippo Bartolucci. All rights reserved.
//

import SwiftUI

struct AddReport: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var addingReport: Bool
    @Binding var reports : [Report]
    
    @State var temperature = ""
    @State var date = Date() // Current Date
    @State var weight = ""
    @State var text = ""
   
    

    
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Temperature").bold()) {
                    TextField("Insert here", text: $temperature)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Weight").bold()) {
                    TextField("Insert here", text: $weight)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Note").bold()) {
                    TextField("Insert here", text: $text)
                }
                
                
                
                if (self.checkValidForm()) {
                    Button(action: {
                        let newReport = Report(date: Date(), temperature: (Float(self.temperature) ?? 0), weight: (Float(self.weight) ?? 0.0), note: (self.text) )
                        self.reports.append(newReport)
                        self.presentationMode.wrappedValue.dismiss()
                       }, label: {
                           Text("Add")
                       })
                }
            }
            .navigationBarTitle("New Report", displayMode: .inline)
            .navigationBarItems(leading:Button(action: {self.presentationMode.wrappedValue.dismiss()}){Text("Cancel")})
            
            
        }
    }
    
    
    private func checkValidForm() -> Bool {
        if (!self.temperature.isEmpty){
            let temp = Float(self.temperature) ?? 0
            if (temp > Float(34.0) && temp < Float(42)){
                return true
            }
        }
        return false
    }
    
}
