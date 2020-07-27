//
//  ReportDetail.swift
//  HealthMonitor
//
//  Created by Filippo Bartolucci on 12/07/2020.
//  Copyright © 2020 Filippo Bartolucci. All rights reserved.
//

import SwiftUI

struct ReportDetail: View {
    @Environment(\.presentationMode) var presentationMode
    @State var editReport = false
    @Binding var reports: [Report]
    var report : Report
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    
    
    private func date2string (d : Date) -> String{
        return String(d.get(.day)) + "/" + String(d.get(.month)) + "/" + String(d.get(.year))
    }
    
    var body: some View {
       
            List{
                HStack {
                    VStack(alignment: .leading) {
                        Group{
                            HStack{
                                Text(date2string(d: report.date))
                                    .foregroundColor(.secondary)
                                Image(systemName: "calendar").foregroundColor(.gray)
                            }
                            Divider()
                        }
                        
                        // MARK: -Temperature
                        Group{
                            HStack{
                                Text("Temperature:")
                                    .bold()
                                    .foregroundColor(.primary)
                                    .lineLimit(3)
                                Spacer()
                                Text(String(report.temperature)+"°C").foregroundColor(.primary)
                                if (report.temperature >= 37.5){
                                    Image(systemName: "flame").foregroundColor(.red)
                                }else{
                                    Image(systemName: "snow").foregroundColor(.blue)
                                }
                            }
                            Text("Importance: " + String(report.temperatureImportance) + "/5")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Divider()
                        }
                        
                        // MARK: -Weight
                        Group{
                            HStack{
                                Text("Weight:")
                                    .bold()
                                    .foregroundColor(.primary)
                                    .lineLimit(3)
                                Spacer()
                                Text(String(report.weight)+" KG").foregroundColor(.primary)
                                Image(systemName: "person").foregroundColor(.green)
                            }
                            Text("Importance: " + String(report.weightImportance) + "/5")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Divider()
                        }
                        
                        // MARK: -Heart Beat
                        Group{
                            HStack{
                                Text("Heart beat:")
                                    .bold()
                                    .foregroundColor(.primary)
                                    .lineLimit(3)
                                Spacer()
                                Text(String(report.heartRate)+" Bpm").foregroundColor(.primary)
                                Image(systemName: "heart").foregroundColor(.red)
                            }
                            Text("Importance: " + String(report.heartRateImportance) + "/5")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Divider()
                        }
                        
                        // MARK: -Note
                        Group{
                            HStack{
                                Text("Note:")
                                    .bold()
                                    .foregroundColor(.primary)
                                    .lineLimit(3)
                                Spacer()
                                Image(systemName: "doc.text").foregroundColor(.yellow)
                            }
                            Text(report.note)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    .layoutPriority(100)
                    
                    Spacer()
                }
                
                
                // MARK: -Buttons
                Section{
                    HStack{
                        Button(action: {
                            self.editReport.toggle()
                        }, label: {
                            Text("Edit Report")
                                .foregroundColor(Color.white)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.9), lineWidth: 1)
                            )
                                .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(15.0)
                        }).padding()
                        
                        Button(action: {
                            if let index = self.reports.firstIndex(of: self.report) {
                                self.reports.remove(at: index)
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }, label: {
                            Text("Delete Report")
                                .foregroundColor(Color.white)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.9), lineWidth: 1)
                            )
                                .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.red]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(15.0)
                        }).padding()
                    }
                }
                
            
        }
    }
}


