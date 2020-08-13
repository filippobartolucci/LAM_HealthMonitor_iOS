//
//  Tab1View.swift
//  HealthMonitor_LAM
//
//  Created by Filippo Bartolucci on 12/08/2020.
//  Copyright © 2020 Filippo Bartolucci. All rights reserved.
//

import SwiftUI

struct Tab1View: View {
    // CoreData Environment
    @Environment(\.managedObjectContext) var managedObjectContext
    var reports: FetchedResults<Report>
    
    // Modal
    @State var addReport : Bool = false
    
    var body: some View {
        NavigationView{
            ScrollView{
                
                
                
                Spacer()
                Section(header: HStack{Text("Last report values");Spacer()}.frame(maxWidth : widthBound)){
                    // MARK: -Temperature
                    boxView(content: AnyView(
                        HStack{
                            Image(systemName: "snow").foregroundColor(Color("lightBlue"))
                            Text("Temperature").foregroundColor(Color("lightBlue"))
                            Spacer()
                            Text(String(reports.first!.temperature)).font(.title)
                            Text("°C").font(.caption)
                        }.padding().frame(minWidth : widthBound,minHeight:55)
                    )).padding(.horizontal)
                    
                    
                    // MARK: -Weight
                    boxView(content: AnyView(
                        HStack{
                            Image(systemName: "person.fill").foregroundColor(Color("purple"))
                            Text("Weight").foregroundColor(Color("purple"))
                            Spacer()
                            Text(String(reports.first!.weight)).font(.title)
                            Text("KG").font(.caption)
                        }.padding().frame(minWidth : widthBound,minHeight:55)
                    )).padding(.horizontal)
                    
                    
                    // MARK: -Heart Rate
                    boxView(content: AnyView(
                        HStack{
                            Group{
                                Image(systemName: "heart.fill")
                                Text("Heart Rate")
                            }.foregroundColor(Color("red"))
                            
                            Spacer()
                            Text(String(reports.first!.heartRate)).font(.title)
                            Text("Bpm").font(.caption)
                        }.padding().frame(minWidth : widthBound,minHeight:55)
                    )).padding(.horizontal)
                }
                
                
                Divider().frame(maxWidth:widthBound)
                
                
                Group{
                    // MARK: -Show All Report
                    NavigationLink(destination:    
                       ReportList(reports:self.reports)
                    ) {
                        boxView(content: AnyView(
                            HStack{
                                Group{
                                    Image(systemName: "folder")
                                    Text("Show all reports")
                                    Spacer()
                                    Image(systemName: "arrow.right").accentColor(Color(.gray))
                                }
                                
                            }.accentColor(Color("greenBlue")).padding(.horizontal).frame(minWidth : widthBound, minHeight: buttonHeight)
                        ))
                    }.padding(.top).frame(maxWidth : widthBound)
                    
                    
                    // MARK: -Add Report
                    Button(action: {
                        self.addReport.toggle()
                    }) {
                        boxView(content: AnyView(
                            HStack{
                                Image(systemName: "plus.square")
                                Text("Add Report")
                                Spacer()
                                Image(systemName: "arrow.right").accentColor(Color(.gray))
                            }.padding(.horizontal).frame(minWidth : widthBound,maxWidth:widthBound, minHeight: buttonHeight)
                        ))
                    }.accentColor(Color("heartRed")).padding(.horizontal)
                    
                    
                    // MARK: -Settings
                    NavigationLink(destination: SettingsView()){
                        boxView(content: AnyView(
                            HStack{
                                Image(systemName: "gear")
                                Text("Settings")
                                Spacer()
                                Image(systemName: "arrow.right")
                            }.accentColor(Color(.gray)).padding(.horizontal).frame(minWidth : widthBound,maxWidth:widthBound, minHeight: buttonHeight)
                        )).padding(.horizontal)
                    }
                    .navigationBarTitle(Text("Summary"), displayMode: .automatic)
                    .sheet(isPresented: $addReport) {
                        addReportView(reports: self.reports).environment(\.managedObjectContext, self.managedObjectContext)
                    }.padding(.bottom)
                }
            }
        }
    }
}
