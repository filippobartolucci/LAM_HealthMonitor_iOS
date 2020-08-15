//
//  ReportDetail.swift
//  HealthMonitor_LAM
//
//  Created by Filippo Bartolucci on 13/08/2020.
//  Copyright © 2020 Filippo Bartolucci. All rights reserved.
//

import SwiftUI

struct ReportDetail: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var reports: FetchedResults<Report>
    var report : Report
    
    
    var body: some View {
        ScrollView{
            VStack{
                Spacer().padding().frame(minHeight:buttonHeight)
                // MARK: -Temperature
                boxView(content: AnyView(
                    HStack{
                        if (report.temperature>37.5){
                            Image(systemName: "flame").foregroundColor(Color(.red))
                            VStack(alignment: .leading){
                                Text("Temperature").foregroundColor(Color(.red))
                                Text("Importance: " + String(report.temperatureImportance) + "/5").font(.caption)
                            }
                        }else{
                            Image(systemName: "snow").foregroundColor(Color("lightBlue"))
                            VStack(alignment: .leading){
                                Text("Temperature").foregroundColor(Color("lightBlue"))
                                Text("Importance: " + String(report.temperatureImportance) + "/5").font(.caption)
                            }
                        }
                        
                        Spacer()
                        Text(String(report.temperature)).font(.title)
                        Text("°C").font(.caption)
                    }.padding().frame(minWidth : widthBound,minHeight:55)
                )).padding(.horizontal)
                
                
                // MARK: -Weight
                boxView(content: AnyView(
                    HStack{
                        Image(systemName: "person.fill").foregroundColor(Color("purple"))
                        VStack(alignment: .leading){
                            Text("Weight").foregroundColor(Color("purple"))
                            Text("Importance: " + String(report.weightImportance) + "/5").font(.caption)
                        }
                        
                        Spacer()
                        Text(String(report.weight)).font(.title)
                        Text("KG").font(.caption)
                    }.padding().frame(minWidth : widthBound,minHeight:55)
                )).padding(.horizontal)
                
                
                // MARK: -Heart Rate
                boxView(content: AnyView(
                    HStack{
                        Image(systemName: "heart.fill").foregroundColor(Color("red"))
                        VStack(alignment: .leading){
                            Text("Heart Rate").foregroundColor(Color("red"))
                            Text("Importance: " + String(report.heartRateImportance) + "/5").font(.caption)
                        }
                        
                        Spacer()
                        Text(String(report.heartRate)).font(.title)
                        Text("Bpm").font(.caption)
                    }.padding().frame(minWidth : widthBound,minHeight:55)
                )).padding(.horizontal)
                
                
                // MARK: -Note
                boxView(content: AnyView(
                    VStack{
                        HStack{
                            Image(systemName: "doc.text").foregroundColor(Color("orange"))
                            Text("Note").foregroundColor(Color("orange"))
                            Spacer()
                        }
                        if (report.note != "" ){
                            HStack{
                                Text((report.note!)).font(.caption)
                                Spacer()
                            }
                        }else{
                            HStack{
                                Text("No note for this report").font(.caption)
                                Spacer()
                            }
                        }
                        
                    }.padding().frame(minWidth : widthBound,minHeight:55)
                )).padding(.horizontal)
                
                Spacer()
                
                Divider().padding(.vertical).frame(minWidth : widthBound)
                
                
                // MARK: -Edit report
                NavigationLink(destination: editReport(report: self.report, temperature: String(self.report.temperature), date: self.report.date!, weight: String(self.report.weight), heartRate: String(self.report.heartRate), text: self.report.note!, tempImportance: self.report.temperatureImportance, weightImportance: self.report.weightImportance, heartImportance: self.report.heartRateImportance)){
                    boxView(content: AnyView(
                        HStack{
                            Image(systemName: "ellipsis")
                            Text("Edit Report")
                            Spacer()
                            Image(systemName: "arrow.right")
                        }.accentColor(Color("heartRed")).padding(.horizontal).frame(minWidth : widthBound,maxWidth:widthBound, minHeight: buttonHeight)
                    )).padding(.horizontal)
                }
            }
        }
        .navigationBarTitle("Report detail")
    }
}

