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
        List(reports){report in
            NavigationLink(destination: ReportDetail(reports: self.$reports, report : report)) {
                ReportRow(report : report)
                .navigationBarTitle(Text("Report list"), displayMode: .inline)
            }
        }
    }
}

