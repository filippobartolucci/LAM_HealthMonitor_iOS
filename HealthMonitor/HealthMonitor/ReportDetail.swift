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
    @State var showSheet = false
    @Binding var reports: [Report]
    var report : Report
    
    
    var body: some View {
        
        List{
            Section(header: Text("Report values")){
                Text(String(self.report.temperature))
                Text(String(self.report.weight))
            }
                
            Section(header: Text("Note")){
                Text(String(self.report.note))
            }
                    
            Section{
                Button(action: {
                    self.showSheet.toggle()
                }) {
                    Text("Delete this report")
                        .foregroundColor(.red)
                }
            }
        }
        .actionSheet(isPresented: $showSheet) {
            ActionSheet(title: Text("Delete report"),message: Text("Are you sure you want to delete this report?"), buttons: [
                .default(Text("Yes").foregroundColor(.red)) { self.deleteReport() },
                .cancel()
            ])
        }
    }
    
    
    private func deleteReport(){
        if let index = self.reports.firstIndex(of: self.report) {
            self.reports.remove(at: index)
            self.mode.wrappedValue.dismiss()
        }
    }
}

