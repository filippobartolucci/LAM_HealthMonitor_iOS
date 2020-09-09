//
//  Tab1View.swift
//  HealthMonitor_LAM
//
//  Created by Filippo Bartolucci on 12/08/2020.
//  Copyright © 2020 Filippo Bartolucci. All rights reserved.
//

import SwiftUI

struct HealthTabView: View {
    // CoreData Environment
    @Environment(\.managedObjectContext) var managedObjectContext
    var reports: FetchedResults<Report>
    
    @FetchRequest(
        entity: Monitoring.entity(),
        sortDescriptors: []
    ) var monitoring: FetchedResults<Monitoring>
    
    @State var notificationManager = LocalNotificationManager()
    
    var body: some View {
        NavigationView{
            ScrollView{
                Group{
                    // conditional view, if there are no reports saved show a welcome screen
                    if (self.reports.isEmpty){
                        // MARK: - Empty reports
                        Spacer()
                        Section{
                            boxView(content: AnyView(
                                HStack{
                                    Group{
                                        Text("Health Monitor is an application that helps you keeping track of your health. Track your body temperature, weight, heart rate and glycemia. See how they vary over time. \n\nTap below and add your first report now")
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
                        }.navigationBarTitle(Text("Summary"), displayMode: .automatic)
                        
                    }else{
                        // MARK: - Non empty reports
                        Spacer()
                        Section(header: HStack{Text("Last report values");Spacer();Text(reports.first!.date!.stringify())}.frame(maxWidth : widthBound)){
                            // MARK: -Temperature
                            boxView(content: AnyView(
                                HStack{
                                    if (reports.first!.temperature>37.5){
                                        Group{
                                            Image(systemName: "flame").accentColor(Color(.red))
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
                            
                            // MARK: -Glycemia
                            boxView(content: AnyView(
                                HStack{
                                    Group{
                                        Image(systemName: "g.circle")
                                        Text("Glycemia")
                                    }.foregroundColor(Color("greenBlue"))
                                    Spacer()
                                    Text(String(reports.first!.glycemia)).font(.title)
                                    Text("mg/dl").font(.caption)
                                }.padding().frame(minWidth : widthBound,minHeight: rowHeight)
                            )).padding(.horizontal)
                        }
                        myDivider()
                        
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
                                        Image(systemName: "arrow.right").accentColor(Color("text"))
                                    }.accentColor(Color("orange")).padding(.horizontal).frame(minWidth : widthBound, minHeight: buttonHeight)
                                ))
                            }.padding(.top).frame(maxWidth : widthBound)
                            
                            // MARK: -Add Report
                            NavigationLink(destination: addReportView(reports: self.reports)) {
                                boxView(content: AnyView(
                                    HStack{
                                        Image(systemName: "plus.square")
                                        Text("Add Report")
                                        Spacer()
                                        Image(systemName: "arrow.right").accentColor(Color("text"))
                                    }.padding(.horizontal).frame(minWidth : widthBound,maxWidth:widthBound, minHeight: buttonHeight)
                                ))
                            }.accentColor(Color("heartRed")).padding(.horizontal)
                            
                            
                            // MARK: -Settings
                            NavigationLink(destination: SettingsView(notificationManager: self.notificationManager)){
                                boxView(content: AnyView(
                                    HStack{
                                        Image(systemName: "gear")
                                        Text("Settings")
                                        Spacer()
                                        Image(systemName: "arrow.right").accentColor(Color("text"))
                                    }.accentColor(Color(.gray)).padding(.horizontal).frame(minWidth : widthBound,maxWidth:widthBound, minHeight: buttonHeight)
                                )).padding(.horizontal)
                            }
                            .navigationBarTitle(Text("Summary"), displayMode: .automatic)
                            .padding(.bottom)
                        }
                    }
                }
            }
        }.onAppear{
            // Check Monitoring data
            self.notificationManager.checkMonitoringNotifications(monitoring: self.monitoring, rs: self.reports)
            for m in self.monitoring {
                if m.daysLeft < 1 {
                    self.managedObjectContext.delete(m)
                    do {
                        try self.managedObjectContext.save()
                    } catch {
                        print("Error saving managed object context: \(error)")
                    }
                }
            }
        }
    }
}
