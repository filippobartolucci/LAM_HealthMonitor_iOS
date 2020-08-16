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
        let checkTemp:Float = Float(self.temperature.replacingOccurrences(of: ",", with: ".")) ?? Float(0)
        print(checkTemp)
        let checkWeight:Float = Float(self.weight.replacingOccurrences(of: ",", with: ".")) ?? Float(0)
        let checkHeart:Int = Int(self.heartRate) ?? 0
        
        if (checkTemp >= 33.0 && checkTemp <= 44.0){
            if (checkWeight > 0.0){
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
        // Temperature
        report.temperature = (report.temperature + Float(self.temperature)!)/2
        if(report.temperatureImportance <= self.tempImportance){
            report.temperatureImportance = Int16(self.tempImportance)
        }
        // Weight
        report.weight = (report.weight + Float(self.weight)!)/2
        if(report.weightImportance <= self.weightImportance){
            report.weightImportance = Int16(self.weightImportance)
        }
        // HeartRate
        report.heartRate = (report.heartRate + Int16(self.heartRate)!)/2
        if(report.heartRateImportance <= self.heartImportance){
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
        ScrollView{
            Spacer()
            
            // MARK: -Date
            
            
            boxView(content: AnyView(
                VStack{
                    NavigationLink(destination: FormView(content: AnyView(
                        VStack{
                            DatePicker("Date", selection: $date, in: ...Date(),displayedComponents: .date).labelsHidden().padding()
                        }
                    )).padding(.horizontal)){
                        HStack{
                            Text("Date: " + date.stringify())
                            Spacer()
                            Image(systemName: "arrow.right")
                        }.padding(.horizontal)
                    }
                }.frame(minHeight:buttonHeight)
            )).padding(.vertical)
            
            // MARK: -Temperature
            boxView(content: AnyView(
                VStack{
                    NavigationLink(destination: FormView(content: AnyView(
                        VStack(alignment: .leading){
                            Form{
                                TextField("Temperature value between 33 and 43", text: $temperature)
                                    .keyboardType(.decimalPad)
                                Stepper("Importance: \(tempImportance)", value: $tempImportance, in: 1...5)
                            }
                            Spacer()
                        }
                    ))){
                        HStack{
                            Text("Temperature: " + String(self.temperature)).multilineTextAlignment(.leading)
                            Spacer()
                            Image(systemName: "arrow.right")
                        }.padding(.horizontal)
                    }
                }.frame(minHeight:buttonHeight)
            )).padding(.vertical)
            
            // MARK: -Weight
            boxView(content: AnyView(
                VStack{
                    NavigationLink(destination: FormView(content: AnyView(
                        VStack(alignment: .leading){
                            Form{
                                TextField("Weight value must be > 0", text: $weight)
                                    .keyboardType(.decimalPad)
                                Stepper("Importance: \(weightImportance)", value: $weightImportance, in: 1...5)
                            }
                            Spacer()
                            
                        }
                    ))){
                        HStack{
                            Text("Weight: " + String(self.weight)).multilineTextAlignment(.leading)
                            Spacer()
                            Image(systemName: "arrow.right")
                        }.padding(.horizontal)
                        
                    }
                }.frame(minHeight:buttonHeight)
            )).padding(.vertical)
            
            // MARK: -Heart Rate
            boxView(content: AnyView(
                VStack{
                    NavigationLink(destination: FormView(content: AnyView(
                        VStack{
                            Form{
                                TextField("Heart rate value must be > 30", text: $heartRate)
                                    .keyboardType(.decimalPad)
                                Stepper("Importance: \(heartImportance)", value: $heartImportance, in: 1...5)
                            }
                            Spacer()
                        }
                    ))){
                        HStack{
                            Text("Heart: " + String(self.heartRate)).multilineTextAlignment(.leading)
                            Spacer()
                            Image(systemName: "arrow.right")
                        }.padding(.horizontal)
                        
                    }
                }.frame(minHeight:buttonHeight)
            )).padding(.vertical)
            
            // MARK: -Note
            boxView(content: AnyView(
                NavigationLink(destination: FormView(content: AnyView(
                    VStack{
                        Form{
                            TextField("Insert here", text: $text)
                        }
                        Spacer()
                    }
                ))){
                    VStack{
                        HStack{
                            Text("Note: ").multilineTextAlignment(.leading)
                            Spacer()
                            Image(systemName: "arrow.right")
                        }.padding(.horizontal)
                        
                        HStack{
                            Text(String(self.text))
                            Spacer()
                        }.padding(.horizontal)
                        
                        
                    }.padding(.vertical)
                }.frame(minHeight:buttonHeight)
            )).padding(.vertical)
            
            Divider()
            
            boxView(content: AnyView(
                Button(action: {
                    self.addReport()
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Add Report").multilineTextAlignment(.leading)
                }.disabled(!self.checkForm()).frame(minHeight:buttonHeight)
            )).padding(.vertical).accentColor(Color(.red))
        }.accentColor(Color("text")).navigationBarTitle("New Report")
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
