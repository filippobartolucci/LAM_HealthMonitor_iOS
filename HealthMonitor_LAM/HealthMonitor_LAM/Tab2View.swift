//
//  Tab2View.swift
//  HealthMonitor_LAM
//
//  Created by Filippo Bartolucci on 12/08/2020.
//  Copyright © 2020 Filippo Bartolucci. All rights reserved.
//

import SwiftUI
import SwiftUICharts

struct Tab2View: View {
    // CoreData Environment
    @Environment(\.managedObjectContext) var managedObjectContext
    var reports: FetchedResults<Report>
    
    @State var pickerValue = 0
    var graphTypes = ["Temp.","Weight","Heart Rate","Glycemia"]
    
    private func createTemperatureArray() -> [Double] {
        var array = [Double]()
        for report in self.reports.reversed(){
            array.append(Double(report.temperature))
        }
        return array
    }
    
    private func createWeightArray() -> [Double] {
        var array = [Double]()
        for report in self.reports.reversed(){
            array.append(Double(report.weight))
        }
        return array
    }
    
    private func createHeartArray() -> [Double] {
        var array = [Double]()
        for report in self.reports.reversed(){
            array.append(Double(report.heartRate))
        }
        return array
    }
    
    private func createGlycemiaArray() -> [Double] {
        var array = [Double]()
        for report in self.reports.reversed(){
            array.append(Double(report.glycemia))
        }
        return array
    }
    
    var body: some View {
        NavigationView{
            ScrollView{
                if (reports.isEmpty){
                    Spacer().frame(minHeight:buttonHeight)
                    Text("Add your first report")
                }else{
                    Spacer()
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
                    
                    Divider().frame(maxWidth: widthBound, minHeight:buttonHeight)
                    
                    Section(header: sectionText(text: "Graphs")){
                        Picker(selection: self.$pickerValue, label: Text("")) {
                            ForEach(0..<self.graphTypes.count){
                                Text(self.graphTypes[$0])
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }.frame(maxWidth: widthBound)
    
                    Group{
                        if (self.pickerValue) == 1{
                            boxView(content: AnyView(
                                LineView(data: self.createWeightArray(), title: "Weight", style: weightStyle()).background(Color("boxBackground")).padding(.horizontal)
                            )).frame(minHeight: graphHeight).padding(.vertical)
                        }else{
                            if (self.pickerValue == 2){
                                boxView(content: AnyView(
                                    LineView(data: self.createHeartArray(), title: "Heart Rate", style: heartStyle()).background(Color("boxBackground")).padding(.horizontal)
                                )).frame(minHeight: graphHeight).padding(.vertical)
                            }else{
                                if (self.pickerValue == 3){
                                    boxView(content: AnyView(
                                        LineView(data: self.createGlycemiaArray(), title: "Glycemia", style: glycemiaStyle()).background(Color("boxBackground")).padding(.horizontal)
                                    )).frame(minHeight: graphHeight).padding(.vertical)
                                }else{
                                    boxView(content: AnyView(
                                        LineView(data: self.createTemperatureArray(), title: "Temperature", style: tempStyle()).background(Color("boxBackground")).padding(.horizontal)
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
