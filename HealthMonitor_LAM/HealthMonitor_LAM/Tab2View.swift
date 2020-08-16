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
    var graphTypes = ["Temperature","Weight","Heart Rate"]
    
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
    
    var body: some View {
        NavigationView{
            ScrollView{
                if (reports.isEmpty){
                    Spacer().frame(minHeight:buttonHeight)
                    Text("Add your first report")
                }else{
                    Spacer()
                    Section(header: HStack{Text("Average values");Spacer()}){
                        avgReportCard(reports:self.reports)
                    }
                    Divider().frame(minHeight:buttonHeight)
                    
                    Section(header: HStack{Text("Graphs");Spacer()}){
                        Picker(selection: self.$pickerValue, label: Text("Filter by:")) {
                            ForEach(0..<self.graphTypes.count){
                                Text(self.graphTypes[$0])
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
    
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
                                boxView(content: AnyView(
                                    LineView(data: self.createTemperatureArray(), title: "Temperature", style: tempStyle()).background(Color("boxBackground")).padding(.horizontal)
                                )).frame(minHeight: graphHeight).padding(.vertical)
                            }
                        }
                    }
                    Spacer().frame(minHeight:buttonHeight)
                }
            }.navigationBarTitle("Dashboard").frame(maxWidth: widthBound)
        }
    }
}
