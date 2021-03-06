//
//  avgReportCard.swift
//  HealthMonitor_LAM
//
//  Created by Filippo Bartolucci on 13/08/2020.
//  Copyright © 2020 Filippo Bartolucci. All rights reserved.
//

import SwiftUI

struct avgReportCard: View {
    // CoreData Environment
    @Environment(\.managedObjectContext) var managedObjectContext
    var reports: FetchedResults<Report>
    
    var body: some View {
        HStack{
            VStack{
                
                //MARK: -Temperature
                Group{
                    boxView(content: AnyView(
                        VStack{
                            if (avgTemperature(report: self.reports) >= 37.5){
                                HStack{
                                    ZStack{
                                        Text(" ")
                                            .frame(width: 30, height: 30)
                                            .background(Color(.gray))
                                            .opacity(0.2)
                                            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                                        Image(systemName: "flame")
                                    }
                                    Text("Avg. Temperature")
                                        .font(.caption)
                                    Spacer()
                                }.offset(x : 20, y:0).foregroundColor(Color(.red))
                            }else{
                                HStack{
                                    ZStack{
                                        Text(" ")
                                            .frame(width: 30, height: 30)
                                            .background(Color(.gray))
                                            .opacity(0.2)
                                            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                                        Image(systemName: "snow")
                                    }
                                    Text("Avg. Temperature")
                                        .font(.caption)
                                    Spacer()
                                }.offset(x : 20, y:0).foregroundColor(Color("lightBlue"))
                            }
                            
                            
                            HStack{
                                Text(String(avgTemperature(report: self.reports))).font(.system(size: 36))
                                Text("°C").font(.system(size: 18)).offset(x:-5)
                            }.offset(x:15, y:-15)
                            
                            Text("Healthy under 37.5").font(.caption)
                        }.frame(maxWidth:squareSize,minHeight:squareSize*0.8)
                    ))
                }
                
                //MARK: -Weight
                Group{
                    boxView(content: AnyView(
                        VStack{
                            HStack{
                                ZStack{
                                    Text(" ")
                                        .frame(width: 30, height: 30)
                                        .background(Color(.gray))
                                        .opacity(0.2)
                                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                                    Image(systemName: "person.fill")
                                }
                                Text("Avg. Weight")
                                    .font(.caption)
                                Spacer()
                            }.offset(x : 20, y:0).foregroundColor(Color("purple"))
                            
                            HStack{
                                Text(String(avgWeight(report: self.reports))).font(.system(size: 36))
                                Text("KG").font(.system(size: 18)).offset(x:-5)
                            }.offset(x:15, y:-15)
                            
                            Text("Stay fit").font(.caption)
                        }.frame(maxWidth:squareSize,minHeight:squareSize*0.8)
                    ))
                }
            }
            Spacer()
            VStack{
                //MARK: -HeartRate
                Group{
                    boxView(content: AnyView(
                        VStack{
                            HStack{
                                ZStack{
                                    Text(" ")
                                        .frame(width: 30, height: 30)
                                        .background(Color(.gray))
                                        .opacity(0.2)
                                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                                    Image(systemName: "heart.fill")
                                }
                                Text("Avg. Hear Rate")
                                    .font(.caption)
                                Spacer()
                            }.offset(x : 20, y:0).foregroundColor(Color("red"))
                            
                            HStack{
                                Text(String(avgHeartRate(report: self.reports))).font(.system(size: 36))
                                Text("Bpm").font(.system(size: 18)).offset(x:-5)
                            }.offset(x:13, y:-15)
                            
                            Text("Stay healthy").font(.caption)
                        }.frame(maxWidth:squareSize,minHeight:squareSize*0.8)
                    ))
                }
                
                //MARK: - Glycemia
                Group{
                    boxView(content: AnyView(
                        VStack{
                            HStack{
                                ZStack{
                                    Text(" ")
                                        .frame(width: 30, height: 30)
                                        .background(Color(.gray))
                                        .opacity(0.2)
                                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                                    Image(systemName: "g.circle")
                                }
                                Text("Glycemia")
                                    .font(.caption)
                                Spacer()
                            }.offset(x : 20, y:0).foregroundColor(Color("greenBlue"))
                            
                            HStack{
                                Text(String(avgGlycemia(report: self.reports))).font(.system(size: 36))
                                Text("mg/dl").font(.system(size: 18)).offset(x:-5)
                            }.offset(x:15, y:-15)
                            Text("Healthy under 126 mg/dl").font(.caption).offset(y:-5)
                        }.frame(maxWidth:squareSize,minHeight:squareSize*0.8)
                    ))
                }
                
                
                
            }
        }.frame(maxWidth: widthBound)
    }
    
    
    private func avgTemperature(report: FetchedResults<Report>) -> Double {
        var avg = 0.0
        for r in report{
            avg += Double(r.temperature)
        }
        return (Double(avg/Double(report.count))*10).rounded()/10
    }
    
    private func avgWeight(report: FetchedResults<Report>) -> Double {
        var avg = 0.0
        for r in report{
            avg += Double(r.weight)
        }
        return (Double(avg/Double(report.count))*10).rounded()/10
    }
    
    private func avgHeartRate(report: FetchedResults<Report>) -> Int {
        var avg = 0.0
        for r in report{
            avg += Double(r.heartRate)
        }
        return (Int(avg/Double(report.count)))
    }
    
    private func avgGlycemia(report: FetchedResults<Report>) -> Int {
        var avg = 0.0
        for r in report{
            avg += Double(r.glycemia)
        }
        return (Int(avg/Double(report.count)))
    }
    
}



