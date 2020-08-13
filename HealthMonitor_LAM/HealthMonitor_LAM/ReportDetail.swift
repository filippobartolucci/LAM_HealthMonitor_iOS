//
//  ReportDetail.swift
//  HealthMonitor_LAM
//
//  Created by Filippo Bartolucci on 13/08/2020.
//  Copyright © 2020 Filippo Bartolucci. All rights reserved.
//

import SwiftUI

struct ReportDetail: View {
    var report : Report
    
    var body: some View {
        ScrollView{
            VStack{
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
                    }.padding().frame(minWidth : UIScreen.main.bounds.size.width*0.9,minHeight:55)
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
                    }.padding().frame(minWidth : UIScreen.main.bounds.size.width*0.9,minHeight:55)
                )).padding(.horizontal)
                
                
                // MARK: -Heart Rate
                boxView(content: AnyView(
                    HStack{
                        Image(systemName: "heart.fill").foregroundColor(Color(.red))
                        VStack(alignment: .leading){
                            Text("Heart Rate").foregroundColor(Color(.red))
                            Text("Importance: " + String(report.heartRateImportance) + "/5").font(.caption)
                        }
                        
                        Spacer()
                        Text(String(report.heartRate)).font(.title)
                        Text("Bpm").font(.caption)
                    }.padding().frame(minWidth : UIScreen.main.bounds.size.width*0.9,minHeight:55)
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
                        
                    }.padding().frame(minWidth : UIScreen.main.bounds.size.width*0.9,minHeight:55)
                )).padding(.horizontal)
                
                Spacer()
            }
        }
        .navigationBarTitle("Report detail")
    }
}

