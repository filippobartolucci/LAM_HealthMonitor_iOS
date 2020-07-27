//
//  ReportList.swift
//  HealthMonitor
//
//  Created by Filippo Bartolucci on 13/07/2020.
//  Copyright © 2020 Filippo Bartolucci. All rights reserved.
//

import SwiftUI


struct ReportList: View {
    @Binding var reports: [Report]
    
    var body: some View {
        Form{
            ScrollView{
                ForEach(reports.reversed()){report in
                    Section{
                        NavigationLink(destination: ReportDetail(reports: self.$reports, report : report)) {
                            ReportCard(report : report).padding(.vertical)
                                // Haptic touch menu
                                .contextMenu {
                                    Button(action: {
                                        self.deleteReport(report: report)
                                    }) {
                                        Text("Delete this report").foregroundColor(.red)
                                        Image(systemName: "trash").foregroundColor(.red)
                                    }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func deleteReport(report : Report){
        if let index = self.reports.firstIndex(of: report) {
            self.reports.remove(at: index)
        }
    }
}

