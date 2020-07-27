//
//  GraphView.swift
//  HealthMonitor
//
//  Created by Filippo Bartolucci on 22/07/2020.
//  Copyright © 2020 Filippo Bartolucci. All rights reserved.
//

import SwiftUI
import SwiftUICharts

struct GraphView: View {
    var reports : [Report]
    
    var body: some View {
        Group{
            Form{
                GraphCard(title : "Temperature", valueArray: self.createTemperatureArray())
                    .padding(.vertical)
                
                Spacer()
                
                GraphCard(title : "Weight", valueArray: self.createWeightArray())
                    .padding(.vertical)
            }
        }
    }
    
    private func createTemperatureArray() -> [Double] {
        var array = [Double]()
        for report in self.reports{
            array.append(Double(report.temperature))
        }
        return array
    }
    
    private func createWeightArray() -> [Double] {
        var array = [Double]()
        for report in self.reports{
            array.append(Double(report.weight))
        }
        return array
    }
}

struct GraphCard : View {
    @Environment(\.colorScheme) var colorScheme
    var title : String
    var valueArray : [Double]
    
    var body :some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    LineView(data: self.valueArray, title: self.title).padding()
                        .scaledToFit()
                        .padding()
                        .offset(y:-40)
                }
                .frame(height:380)
                .layoutPriority(100)
            }
        }
        .background(colorScheme == .dark ? Color.black : Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 7, x: 0, y: 2)
        .padding(.horizontal)
    }
}


