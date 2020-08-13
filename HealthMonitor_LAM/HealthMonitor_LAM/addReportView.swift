//
//  addReport.swift
//  HealthMonitor_LAM
//
//  Created by Filippo Bartolucci on 12/08/2020.
//  Copyright © 2020 Filippo Bartolucci. All rights reserved.
//

import SwiftUI

struct addReportView: View {
    // Modal
    @Environment(\.presentationMode) private var presentationMode
    
    
    
    // MARK: -Report Values
    @State var temperature = ""
    @State var date = Date()
    @State var weight = ""
    @State var heartRate = ""
    @State var text = ""
    
    
    // MARK: -Report Importance
    @State var tempImportance = 3
    @State var weightImportance = 3
    @State var heartImportance = 3
    
    // Enable "Add Report" button
    func checkForm() -> Bool {
        let checkTemp:Float = Float(self.temperature) ?? Float(0)
        let checkWeight:Float = Float(self.weight) ?? Float(0)
        let checkHeart:Int = Int(self.heartRate) ?? 0
        
        if (checkTemp >= 33 && checkTemp <= 44){
            if (checkWeight >= 0){
                if (checkHeart >= 20){
                    return true
                }
            }
        }
        return false
    }
    
    // CoreData Management
    @Environment(\.managedObjectContext) var managedObjectContext
    var reports: FetchedResults<Report>
    
    func addReport() {
        for report in reports{
            if (compareDate(date1: report.date!, date2: self.date)){
                print("Updating report...")
                updateReport(report: report)
                return
            }
        }
        print("Creating new report...")
        createNewReport()
        return
    }
    
    func createNewReport(){
        let r = Report(context: managedObjectContext)
        
        r.id = UUID()
        r.date = self.date
        
        r.temperature = Float(self.temperature)!
        r.temperatureImportance = Int16(self.tempImportance)
        
        
        r.weight = Float(self.weight)!
        r.weightImportance = Int16(self.weightImportance)
        
        r.heartRate = Int16(self.heartRate)!
        r.heartRateImportance = Int16(self.heartImportance)
        
        r.note = self.text
        
        saveContext()
    }
    
    func updateReport(report:Report){
        if(report.temperatureImportance <= self.tempImportance){
            report.temperature = Float(self.temperature)!
            report.temperatureImportance = Int16(self.tempImportance)
        }
        if(report.weightImportance <= self.weightImportance){
            report.weight = Float(self.weight)!
            report.weightImportance = Int16(self.weightImportance)
        }
        if(report.heartRateImportance <= self.heartImportance){
            report.heartRate = Int16(self.temperature)!
            report.heartRateImportance = Int16(self.weightImportance)
        }
        saveContext()
    }
    
    func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }
    
    var body: some View {
        NavigationView{
            
            
            Form{
                // MARK: -Date
                Section{
                    NavigationLink(destination: FormView(content: AnyView(
                        VStack{
                            DatePicker("Date", selection: $date, in: ...Date(),displayedComponents: .date).labelsHidden().padding()
                        }
                    )).padding(.horizontal)){
                        
                        Text("Date: " + date.stringify())
                        
                    }
                }
                
                
                Section{
                    
                    NavigationLink(destination: FormView(content: AnyView(
                        VStack{
                            Form{
                                TextField("Value between 33 and 43", text: $temperature)
                                    .keyboardType(.decimalPad)
                                Stepper("Importance: \(tempImportance)", value: $tempImportance, in: 1...5)
                            }
                            Spacer()
                        }
                    ))){
                        
                        Text("Temperature: " + String(self.temperature))
                    }
                }
                
                // MARK: -Weight
                Section{
                    NavigationLink(destination: FormView(content: AnyView(
                        VStack{
                            Form{
                                TextField("Value must be > 0", text: $weight)
                                    .keyboardType(.decimalPad)
                                Stepper("Importance: \(weightImportance)", value: $weightImportance, in: 1...5)
                            }
                            Spacer()
                            
                        }
                    ))){
                        
                        Text("Weight: " + String(self.weight))
                    }
                }
                
                // MARK: -Heart Rate
                Section{
                    NavigationLink(destination: FormView(content: AnyView(
                        VStack{
                            Form{
                                TextField("Value must be > 30", text: $heartRate)
                                    .keyboardType(.decimalPad)
                                Stepper("Importance: \(heartImportance)", value: $heartImportance, in: 1...5)
                            }
                            Spacer()
                        }
                    ))){
                        
                        Text("Heart: " + String(self.heartRate))
                    }
                }
                
                // MARK: -Heart Rate
                Section{
                    NavigationLink(destination: FormView(content: AnyView(
                        VStack{
                            Form{
                               TextField("Insert here", text: $text)
                            }
                            Spacer()
                        }
                    ))){
                        Text("Note: ")
                        Text(String(self.text))
                    }
                }
                
                Section{
                    Button(action: {
                        self.addReport()
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Add report")
                    }.disabled(!self.checkForm())
                }
            }
                
                
            .navigationBarTitle("New Report", displayMode: .inline).accentColor(.red)
        }.accentColor(.red)
    }
}



struct FormView: View {
    var content : AnyView
    
    var body : some View {
        Group{
            self.content
        }
    }
}
