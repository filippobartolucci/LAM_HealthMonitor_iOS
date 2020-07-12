//
//  ReportRow.swift
//  HealthMonitor
//
//  Created by Filippo Bartolucci on 12/07/2020.
//  Copyright © 2020 Filippo Bartolucci. All rights reserved.
//

import SwiftUI

struct ReportRow: View {
    let report : Report
    
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    var body: some View {
        HStack{
            Text(ReportRow.self.dateFormatter.string(from: report.date))
            Spacer()
            Text(String(format:"%.1f", report.temperature)+" C")
        }
    }
}

struct ReportRow_Previews: PreviewProvider {
    static var previews: some View {
        ReportRow(report: Report(date : Date(timeIntervalSince1970: 1056730041), temperature: 37.5))
    }
}
