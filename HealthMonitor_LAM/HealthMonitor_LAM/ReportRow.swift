//
//  ReportRow.swift
//  HealthMonitor_LAM
//
//  Created by Filippo Bartolucci on 13/08/2020.
//  Copyright © 2020 Filippo Bartolucci. All rights reserved.
//

import SwiftUI

struct ReportRow: View {
    var report : Report
    
    var body: some View {
        Group{
            if (report.date != nil){
                HStack{
                    Text("Report of: ").font(.system(size: 18))
                    Text(report.date!.stringify()).font(.system(size: 18)).bold()
                    Spacer()
                    
                }.frame(minHeight : buttonHeight)
            }else{
                Spacer().frame(maxHeight:0)
            }
        }
    }
}


