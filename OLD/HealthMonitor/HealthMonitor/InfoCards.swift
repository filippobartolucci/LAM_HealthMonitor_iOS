//
//  InfoCards.swift
//  HealthMonitor
//
//  Created by Filippo Bartolucci on 22/07/2020.
//  Copyright © 2020 Filippo Bartolucci. All rights reserved.
//

import SwiftUI

struct InfoCards: View {
    @Environment(\.colorScheme) var colorScheme
    
    var reports : [Report]
    
    var body: some View {
        ScrollView(.horizontal){
            HStack{
                infoCard(content: AnyView(
                    VStack(alignment: .leading) {
                        HStack{
                            Text("Avg. Temp")
                                .font(.caption)
                            Spacer()
                            if (avgTemperature(report: self.reports) >= 37.5){
                                ZStack{
                                    Text(" ")
                                        .frame(width: 30, height: 30)
                                        .background(Color(.gray))
                                        .opacity(0.2)
                                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                                    Image(systemName: "flame").foregroundColor(.red)
                                }
                            }else{
                                ZStack{
                                    Text(" ")
                                        .frame(width: 30, height: 30)
                                        .background(Color(.gray))
                                        .opacity(0.2)
                                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                                    Image(systemName: "snow").foregroundColor(.blue)
                                }
                            }
                        }
                        .offset(y:-5)
                        
                        Text(String(avgTemperature(report: self.reports)) + "°C")
                            .offset(y:-10)
                            .font(.largeTitle)
                        
                        VStack{
                            Text("Under 37.5 \n Healthy")
                                .font(.caption)
                                .multilineTextAlignment(.trailing)
                        }.offset(x:60 )
                }))
                
                
                infoCard(content: AnyView(
                    VStack(alignment: .leading) {
                        HStack{
                            Text("Avg. Weight")
                                .font(.caption)
                            Spacer()
                            ZStack{
                                Text(" ")
                                    .frame(width: 30, height: 30)
                                    .background(Color(.gray))
                                    .opacity(0.2)
                                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                                Image(systemName: "person").foregroundColor(.green)
                            }
                        }
                        .offset(y:-5)
                        Text(String(avgWeight(report: self.reports)) + " KG")
                            .offset(y:-10)
                            .font(.largeTitle)
                        VStack{
                            Text("Stay \n Healthy")
                                .font(.caption)
                                .multilineTextAlignment(.trailing)
                        }.offset(x:60 )
                    }
                    .layoutPriority(100)
                ))
                
                
                infoCard(content: AnyView(
                    VStack(alignment: .leading) {
                        HStack{
                            Text("Avg. Heart Rate")
                                .font(.caption)
                            Spacer()
                            ZStack{
                                Text(" ")
                                    .frame(width: 30, height: 30)
                                    .background(Color(.gray))
                                    .opacity(0.2)
                                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                                Image(systemName: "heart").foregroundColor(.red)
                            }
                        }
                        .offset(y:-5)
                        Text(String(avgHeartRate(report: self.reports)) + " Bpm")
                            .offset(y:-10)
                            .font(.largeTitle)
                        VStack{
                            Text("Stay \n Fit")
                                .font(.caption)
                                .multilineTextAlignment(.trailing)
                        }.offset(x:80 )
                    }
                    .layoutPriority(100)
                ))
            }.padding()
        }
    }
    
    func avgTemperature(report: [Report]) -> Double {
        var avg = 0.0
        for r in report{
            avg += Double(r.temperature)
        }
        return (Double(avg/Double(report.count))*10).rounded()/10
    }
    
    func avgWeight(report: [Report]) -> Double {
        var avg = 0.0
        for r in report{
            avg += Double(r.weight)
        }
        return (Double(avg/Double(report.count))*10).rounded()/10
    }
    
    func avgHeartRate(report: [Report]) -> Int {
        var avg = 0.0
        for r in report{
            avg += Double(r.heartRate)
        }
        return (Int(avg/Double(report.count)))
    }
    
}


struct infoCard: View {
    @Environment(\.colorScheme) var colorScheme
    var content : AnyView
    
    var body : some View {
        Group{
            VStack {
                HStack{
                    self.content
                }
                .padding()
            }
            .frame(width: 150, height: 150)
            .background(colorScheme == .dark ? Color.black : Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 7, x: 0, y: 2)
        }.frame(width: 160)
    }
}
