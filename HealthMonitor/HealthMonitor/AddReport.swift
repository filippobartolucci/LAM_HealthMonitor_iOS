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
    
    // MARK: -Report Values
    @State var temperature = ""
    @State var date : Date 
    @State var weight = ""
    @State var heartRate = ""
    @State var text = ""
    
    // MARK: -Report Importance
    @State var tempImportance = 3
    @State var weightImportance = 3
    @State var heartImportance = 3
    
    
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Temperature").bold()) {
                    TextField("Value between 33 and 43", text: $temperature)
                        .keyboardType(.decimalPad)
                    
                    
                    VStack {
                        Stepper("Importance: \(tempImportance)", value: $tempImportance, in: 1...5)
                    }
                }
                
                Section(header: Text("Weight").bold()) {
                    TextField("Insert here", text: $weight)
                        .keyboardType(.decimalPad)
                    VStack {
                        Stepper("Importance: \(weightImportance)", value: $weightImportance, in: 1...5)
                    }
                }
                
                Section(header: Text("Hear Rate").bold()) {
                    TextField("Insert here", text: $heartRate)
                        .keyboardType(.numberPad)
                    VStack {
                        Stepper("Importance: \(heartImportance)", value: $heartImportance, in: 1...5)
                    }
                }
                
                Section(header: Text("Note").bold()) {
                    TextField("Insert here", text: $text)
                }
                
                if (self.checkValidForm()) {
                    Button(action: {
                        let newReport = Report(date: self.date, temperature: (Float(self.temperature)!),temperatureImportance: self.tempImportance, weight: (Float(self.weight)!), weightImportance: self.weightImportance,note: (self.text) )
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
            if (temp > Float(33.0) && temp < Float(43)){
                if ((Float(self.weight) ?? 0.0) > 0.0 ){
                    return true
                }
            }
        }
        return false
    }
    
    private func add2Reports(r : Report, reports : [Report]){
    
    }
}
