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
            Group{
                if (reports.isEmpty){
                    Text("Add your first report")
                }else{
                    ScrollView{
                        Spacer()
                        Section(header: HStack{Text("Average values");Spacer()}.frame(maxWidth : widthBound)){
                            avgReportCard(reports:self.reports)
                        }
                        Spacer().frame(minHeight:buttonHeight)
                        Section(header: HStack{Text("Graphs");Spacer()}.frame(maxWidth : widthBound)){
                            boxView(content: AnyView(
                                LineView(data: self.createTemperatureArray(), title: "Temperature", style: tempStyle()).background(Color("boxBackground")).padding(.horizontal)
                            )).frame(minHeight:350)
                            
                            boxView(content: AnyView(
                                LineView(data: self.createWeightArray(), title: "Weight", style: weightStyle()).background(Color("boxBackground")).padding(.horizontal)
                            )).frame(minHeight:350).padding(.vertical)
                            
                            boxView(content: AnyView(
                                LineView(data: self.createHeartArray(), title: "Heart Rate", style: heartStyle()).background(Color("boxBackground")).padding(.horizontal)
                            )).frame(minHeight:350)
                        }
                        Spacer().frame(minHeight:buttonHeight)
                    }
                }
            }.navigationBarTitle("Dashboard")
        }
    }
}
