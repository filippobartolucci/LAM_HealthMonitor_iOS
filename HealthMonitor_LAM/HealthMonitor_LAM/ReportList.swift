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
    
    // Filter list
    @State var pickerValue : Int = 0
    var filterValue = ["None","Temp.","Weight","H.R.","Glyc."]
    @State var importance = 1
    
    private func filterList() -> [FetchedResults<Report>.Element] {
        switch self.pickerValue {
        case 1:
            return self.reports.filter({
                $0.temperatureImportance>=self.importance
            })
        case 2:
            return self.reports.filter({
                $0.weightImportance>=self.importance
            })
            
        case 3:
            return self.reports.filter({
                $0.heartRateImportance>=self.importance
            })
        case 4:
            return self.reports.filter({
                $0.glycemiaImportance>=self.importance
            })
        default:
            return self.reports.filter({
                $0.temperatureImportance>=0
            })
        }
    }
    
    func deleteReport(at offsets: IndexSet) {
        print("Deleting report...")
        
        offsets.forEach { index in
            let report = filterList()[index]
            self.managedObjectContext.delete(report)
        }
        
        saveContext()
        print("report deleted.")
    }
    
    func saveContext() {
        do {
            try self.managedObjectContext.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }
    
    var body: some View {
        List{
            Section{
                Picker(selection: self.$pickerValue, label: Text("Filter by:")) {
                    ForEach(0..<self.filterValue.count){
                        Text(self.filterValue[$0])
                    }
                }.pickerStyle(SegmentedPickerStyle())
                if(self.pickerValue != 0) {
                    Stepper("Importance: \(importance)", value: $importance, in: 1...5)
                }
            }
            Section{
                ForEach(filterList(), id: \.date) {report in
                    NavigationLink(destination: ReportDetail(reports:self.reports, report: report)){
                        ReportRow(report: report)
                    }
                }.onDelete(perform: self.deleteReport)
                
            }
        }.navigationBarTitle("Report list")
    }
    
}
