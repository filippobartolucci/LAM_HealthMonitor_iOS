//
//  Tab1NoReportView.swift
//  HealthMonitor_LAM
//
//  Created by Filippo Bartolucci on 12/08/2020.
//  Copyright © 2020 Filippo Bartolucci. All rights reserved.
//

import SwiftUI

struct Tab1NoReportView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    var reports: FetchedResults<Report>
    
    @State var addReport : Bool = false
    
    var body: some View {
        NavigationView{
            ScrollView{
                Spacer()
                

                Section(){
                    // MARK: -Heart Rate
                    boxView(content: AnyView(
                        HStack{
                            Group{
                                Text("Healt Monitor is an application that helps you keeping track of your healt. Track your body temperature, weight and heart rate and see how they vary over time. \n\nTap below and add your first report now")
                            }
                            
                        }.padding().frame(minWidth : UIScreen.main.bounds.size.width*0.9,minHeight:55)
                    )).padding(.horizontal)
                }
                
                Group{
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
                            }.padding(.horizontal).frame(minWidth : UIScreen.main.bounds.size.width*0.9,maxWidth:UIScreen.main.bounds.size.width*0.9, minHeight: buttonHeight)
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
                            }.accentColor(Color(.gray)).padding(.horizontal).frame(minWidth : UIScreen.main.bounds.size.width*0.9,maxWidth:UIScreen.main.bounds.size.width*0.9, minHeight: buttonHeight)
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

