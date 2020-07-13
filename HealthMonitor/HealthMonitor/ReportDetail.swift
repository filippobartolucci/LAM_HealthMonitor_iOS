//
//  ReportDetail.swift
//  HealthMonitor
//
//  Created by Filippo Bartolucci on 12/07/2020.
//  Copyright © 2020 Filippo Bartolucci. All rights reserved.
//

import SwiftUI

struct ReportDetail: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Binding var reports: [Report]
    
    let report : Report
    
    var body: some View {
        
        HStack{
//            Text(String(format:"%.1f", report.temperature)+" C")
            Form{
                Button(action: {
                    self.deleteReport()
                }) {
                    Text("Delete this report")
                    .foregroundColor(.red)
                }
                
            }
        }
       
    }
    
    private func deleteReport(){
        if let index = self.reports.firstIndex(of: self.report) {
            self.reports.remove(at: index)
            self.mode.wrappedValue.dismiss()
        }
    }
}

