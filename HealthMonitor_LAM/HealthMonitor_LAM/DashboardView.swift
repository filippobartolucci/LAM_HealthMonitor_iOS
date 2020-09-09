//
//  Tab2View.swift
//  HealthMonitor_LAM
//
//  Created by Filippo Bartolucci on 12/08/2020.
//  Copyright © 2020 Filippo Bartolucci. All rights reserved.
//

import SwiftUI
import SwiftUICharts

struct DashboardView: View {
    // CoreData Environment
    @Environment(\.managedObjectContext) var managedObjectContext
    var reports: FetchedResults<Report>
    
    // Value and picker selected value for graphs
    @State var pickerValue = 0
    var graphTypes = ["Temp.","Weight","Heart Rate","Glycemia"]
    
    var body: some View {
        NavigationView{
            ScrollView{
                if (reports.isEmpty){
                    // no reports saved
                    Spacer().frame(minHeight:buttonHeight)
                    
                    boxView(content: AnyView(
                        Text("Add your first report in Health tab").frame(minWidth: widthBound, minHeight: buttonHeight)
                    ))
                    
                    
                }else{
                    Spacer()
                    
                    // Avg card
                    Section(header: sectionText(text: "Average values")){
                        avgReportCard(reports:self.reports)
                    }
                    //MARK: -Report Number
                    boxView(content: AnyView(
                        HStack{
                            Group{
                                Image(systemName: "doc")
                                Text("Number of reports")
                            }.foregroundColor(Color("orange"))
                            Spacer()
                            Text(String(reports.count)).font(.title)
                        }.padding().frame(minWidth : widthBound,minHeight: rowHeight)
                    )).padding(.horizontal)
                    
                    myDivider().frame(minHeight:buttonHeight)
                    
                    // Picker for graphs
                    Section(header: sectionText(text: "Graphs")){
                        Picker(selection: self.$pickerValue, label: Text("")) {
                            ForEach(0..<self.graphTypes.count){
                                Text(self.graphTypes[$0])
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }.frame(maxWidth: widthBound)
                    
                    // Graphs, choose from the picker which one to display
                    Group{
                        if (self.pickerValue) == 1{
                            boxView(content: AnyView(
                                LineView(data: createWeightArray(reports : self.reports), title: "Weight", style: weightStyle()).background(Color("boxBackground")).padding(.horizontal)
                            )).frame(minHeight: graphHeight).padding(.vertical)
                        }else{
                            if (self.pickerValue == 2){
                                boxView(content: AnyView(
                                    LineView(data: createHeartArray(reports : self.reports), title: "Heart Rate", style: heartStyle()).background(Color("boxBackground")).padding(.horizontal)
                                )).frame(minHeight: graphHeight).padding(.vertical)
                            }else{
                                if (self.pickerValue == 3){
                                    boxView(content: AnyView(
                                        LineView(data: createGlycemiaArray(reports : self.reports), title: "Glycemia", style: glycemiaStyle()).background(Color("boxBackground")).padding(.horizontal)
                                    )).frame(minHeight: graphHeight).padding(.vertical)
                                }else{
                                    boxView(content: AnyView(
                                        LineView(data: createTemperatureArray(reports : self.reports), title: "Temperature", style: tempStyle()).background(Color("boxBackground")).padding(.horizontal)
                                    )).frame(minHeight: graphHeight).padding(.vertical)
                                }
                                
                            }
                        }
                    }
                    Spacer().frame(minHeight:buttonHeight)
                }
            }.navigationBarTitle("Dashboard").frame(maxWidth: widthBound)
        }
    }
}
