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
    
    
    var body: some View {
        NavigationView{
            ScrollView{
                Group{
                    if (self.reports.isEmpty){
                        // MARK: - Empty reports
                        Spacer()
                        Section{
                            boxView(content: AnyView(
                                HStack{
                                    Group{
                                        Text("Healt Monitor is an application that helps you keeping track of your healt. Track your body temperature, weight and heart rate and see how they vary over time. \n\nTap below and add your first report now")
                                    }
                                    
                                }.padding().frame(minWidth: widthBound,minHeight: rowHeight)
                            )).padding(.horizontal)
                        }
                        
                        Group{
                            // MARK: -Add Report
                            NavigationLink(destination: addReportView(reports: self.reports)) {
                                boxView(content: AnyView(
                                    HStack{
                                        Image(systemName: "plus.square")
                                        Text("Add Report")
                                        Spacer()
                                        Image(systemName: "arrow.right").accentColor(Color(.gray))
                                    }.padding(.horizontal).frame(minWidth : widthBound, maxWidth: widthBound, minHeight: buttonHeight)
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
                                    }.accentColor(Color(.gray)).padding(.horizontal).frame(minWidth : widthBound, maxWidth: widthBound, minHeight: buttonHeight)
                                )).padding(.horizontal)
                            }
                            .navigationBarTitle(Text("Summary"), displayMode: .automatic)
                            .padding(.bottom)
                        }
                        
                    }else{
                        
                        // MARK: - Non empty reports
                        Spacer()
                        Section(header: HStack{Text("Last report values");Spacer();Text(reports.first!.date!.stringify())}.frame(maxWidth : widthBound)){
                            // MARK: -Temperature
                            boxView(content: AnyView(
                                HStack{
                                    if (reports.first!.temperature>37.5){
                                        Group{
                                            Image(systemName: "flame")
                                            VStack(alignment: .leading){
                                                Text("Temperature")
                                            }.foregroundColor(Color(.red))
                                        }
                                    }else{
                                        Group{
                                            Image(systemName: "snow")
                                            VStack(alignment: .leading){
                                                Text("Temperature")
                                            }
                                        }.foregroundColor(Color("lightBlue"))
                                    }
                                    Spacer()
                                    Text(String(reports.first!.temperature)).font(.title)
                                    Text("°C").font(.caption)
                                }.padding().frame(minWidth : widthBound,minHeight: rowHeight)
                            )).padding(.horizontal)
                            
                            
                            // MARK: -Weight
                            boxView(content: AnyView(
                                HStack{
                                    Group{
                                        Image(systemName: "person.fill")
                                        Text("Weight")
                                    }.foregroundColor(Color("purple"))
                                    Spacer()
                                    Text(String(reports.first!.weight)).font(.title)
                                    Text("KG").font(.caption)
                                }.padding().frame(minWidth : widthBound,minHeight: rowHeight)
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
                                }.padding().frame(minWidth : widthBound,minHeight: rowHeight)
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
                                        Image(systemName: "folder")
                                        Text("Show all reports")
                                        Spacer()
                                        Image(systemName: "arrow.right").accentColor(Color(.gray))
                                    }.accentColor(Color("greenBlue")).padding(.horizontal).frame(minWidth : widthBound, minHeight: buttonHeight)
                                ))
                            }.padding(.top).frame(maxWidth : widthBound)
                            
                            
                            // MARK: -Add Report
                            NavigationLink(destination: addReportView(reports: self.reports)) {
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
                            .padding(.bottom)
                        }
                        
                    }
                }
                
            }
        }
    }
}
