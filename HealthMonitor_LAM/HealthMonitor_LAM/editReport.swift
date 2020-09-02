//
//  editReport.swift
//  HealthMonitor_LAM
//
//  Created by Filippo Bartolucci on 14/08/2020.
//  Copyright © 2020 Filippo Bartolucci. All rights reserved.
//

import SwiftUI
import CoreData

struct editReport: View {
    @State var report : Report
    @Environment(\.presentationMode) private var presentationMode
    
    // MARK: -Report Values
    @State var temperature : String
    @State var date : Date
    @State var weight : String
    @State var heartRate : String
    @State var glycemia : String
    @State var text : String
    
    
    // MARK: -Report Importance
    @State var tempImportance : Int16
    @State var weightImportance : Int16
    @State var heartImportance : Int16
    @State var glycemiaImportance : Int16
    
    // MARK: -CoreData
    @Environment(\.managedObjectContext) var managedObjectContext
    
    func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }
    
    func updateReport(){
        self.report.temperature = Float(self.temperature.replacingOccurrences(of: ",", with: "."))!
        self.report.weight = Float(self.weight.replacingOccurrences(of: ",", with: "."))!
        self.report.heartRate = Int16(self.heartRate)!
        self.report.glycemia = Int16(self.glycemia)!
        self.report.note = self.text
        self.report.temperatureImportance = Int16(self.tempImportance)
        self.report.weightImportance = Int16(self.weightImportance)
        self.report.heartRateImportance = Int16(self.heartImportance)
        self.report.glycemiaImportance = Int16(self.glycemiaImportance)
        
        saveContext()
    }
    
    // Enable "Update report" button
   func checkForm() -> Bool {
       let checkTemp: Float = Float(self.temperature.replacingOccurrences(of: ",", with: ".")) ?? Float(0)
       let checkWeight: Float = Float(self.weight.replacingOccurrences(of: ",", with: ".")) ?? Float(0)
       let checkHeart: Int = Int(self.heartRate) ?? 0
       let checkGlycemia: Int = Int(self.glycemia) ?? 0
       
       if (checkTemp >= 33.0 && checkTemp <= 44.0){
           if (checkWeight > 0.0){
               if (checkHeart >= 20){
                   if (checkGlycemia >= 50){
                       return true
                   }
               }
           }
       }
       return false
   }
    
    
    var body: some View {
        ScrollView{
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
            ))
            
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
            
            // MARK: -Glycemia
            boxView(content: AnyView(
                VStack{
                    NavigationLink(destination: FormView(content: AnyView(
                        VStack{
                            Form{
                                TextField("Glycemia value must be > 50", text: $glycemia)
                                    .keyboardType(.decimalPad)
                                Stepper("Importance: \(glycemiaImportance)", value: $glycemiaImportance, in: 1...5)
                            }
                            Spacer()
                        }
                    ))){
                        HStack{
                            Text("Glycemia: " + String(self.glycemia)).multilineTextAlignment(.leading)
                            Spacer()
                            Image(systemName: "arrow.right")
                        }.padding(.horizontal)
                        
                    }
                }.frame(minHeight:buttonHeight)
            ))
            
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
            
            // MARK: -Update Report
            boxView(content: AnyView(
                Button(action: {
                    self.updateReport()
                    self.presentationMode.wrappedValue.dismiss()
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Update report").multilineTextAlignment(.leading)
                }.disabled(!self.checkForm()).frame(minHeight:buttonHeight)
            )).padding(.vertical).accentColor(Color(.red))
            
        }.navigationBarTitle("Edit report").accentColor(Color("text"))
    }
}


