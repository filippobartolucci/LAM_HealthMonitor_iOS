//
//  ReportCard.swift
//  HealthMonitor
//
//  Created by Filippo Bartolucci on 15/07/2020.
//  Copyright © 2020 Filippo Bartolucci. All rights reserved.
//

import SwiftUI

struct ReportCard: View {
    var report : Report
    
    
    private func date2string (d : Date) -> String{
        return String(d.get(.day)) + "/" + String(d.get(.month)) + "/" + String(d.get(.year))
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    HStack{
                        Text(date2string(d: report.date))
                        .foregroundColor(.secondary)
                        Spacer()
                        Image(systemName: "arrow.right").foregroundColor(.gray)
                    }
                    Divider()
                    HStack{
                        Text("Temperature:")
                            .bold()
                            .foregroundColor(.primary)
                            .lineLimit(3)
                        Spacer()
                        Text(String(report.temperature)+"C").foregroundColor(.primary)
                        if (report.temperature >= 37.5){
                            Image(systemName: "flame").foregroundColor(.red)
                        }else{
                            Image(systemName: "snow").foregroundColor(.blue)
                        }
                    }
                    Text("Importance: " + String(report.temperatureImportance) + "/5")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Divider()
                    HStack{
                        Text("Weight:")
                            .bold()
                            .foregroundColor(.primary)
                            .lineLimit(3)
                        Spacer()
                        Text(String(report.weight)+"KG").foregroundColor(.primary)
                        Image(systemName: "person").foregroundColor(.green)
                    }
                    Text("Importance: " + String(report.weightImportance) + "/5")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Divider()
                    HStack{
                        Text("Note:")
                            .bold()
                            .foregroundColor(.primary)
                            .lineLimit(3)
                        Spacer()
                        //Text(String(report.weight)+"KG").foregroundColor(.primary)
                        Image(systemName: "doc.text").foregroundColor(.yellow)
                    }
                    Text(report.note)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    
                }
                .layoutPriority(100)
                
                Spacer()
            }
            .padding()
        }
        .background(Color.gray.opacity(0))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.9), lineWidth: 1)
        ).padding([.horizontal])
            
    }
}

struct ReportCard_Previews: PreviewProvider {
    static var previews: some View {
        ReportCard(report: Report(date : Date(timeIntervalSince1970: 1056535641), temperature: 37.5, weight: 60))
    }
}
