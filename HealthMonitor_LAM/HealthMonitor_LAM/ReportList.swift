//
//  ReportLis.swift
//  HealthMonitor_LAM
//
//  Created by Filippo Bartolucci on 13/08/2020.
//  Copyright © 2020 Filippo Bartolucci. All rights reserved.
//

import SwiftUI

struct ReportList: View {
    // CoreData Environment
    @Environment(\.managedObjectContext) var managedObjectContext
    var reports: FetchedResults<Report>

    
    func deleteReport(at offsets: IndexSet) {
        offsets.forEach { index in
            let report = self.reports[index]
            self.managedObjectContext.delete(report)
        }
        saveContext()
    }
    
    func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }
    
    var body: some View {
        Group{
            List{
                ForEach(reports, id: \.date) {report in
                    NavigationLink(destination: ReportDetail(reports:self.reports, report: report)){
                    ReportRow(report: report)
                }
              }
              .onDelete(perform: self.deleteReport)
            }.navigationBarTitle("Report list")
        }
    }
}
