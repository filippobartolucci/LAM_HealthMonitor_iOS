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
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    
    private func createTemperatureArray(reports : [Report]) -> [Double] {
        var array = [Double]()
        for report in reports{
            array.append(Double(report.temperature))
        }
        return array
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView()
    }
}

