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
    
    var avgTemp = 38.6
    var avgWeight = 38.6
    
    var body: some View {
        ScrollView(.horizontal){
            HStack{
                VStack {
                    HStack{
                        VStack(alignment: .leading) {
                            HStack{
                                Text("Avg. Temp")
                                    .font(.caption)
                                Spacer()
                                if (avgTemp >= 37.5){
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
                            
                            Text(String(self.avgTemp) + "°C")
                                .offset(y:-10)
                                .font(.largeTitle)
                            
                            VStack{
                                Text("Under 37.5")
                                    .font(.caption)
                                Text("Healthy")
                                    .font(.caption)
                                    .offset(x:10)
                            }.offset(x:60 )
                            
                        }
                        .layoutPriority(100)
                        Spacer()
                    }
                    .padding()
                }
                .frame(width: 150, height: 150)
                .background(colorScheme == .dark ? Color.black : Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                .shadow(color: Color.black.opacity(0.2), radius: 7, x: 0, y: 2)
                
                Spacer().padding(.horizontal)
                
                VStack {
                    HStack{
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
                            
                            Text("64 Kg.")
                                .offset(y:-10)
                                .font(.largeTitle)
                            
                            VStack{
                                Text("Under 37.5")
                                    .font(.caption)
                                Text("Healthy")
                                    .font(.caption)
                                    .offset(x:10)
                            }.offset(x:60 )
                            
                        }
                        .layoutPriority(100)
                        Spacer()
                    }
                    .padding()
                }
                .frame(width: 150, height: 150)
                .background(colorScheme == .dark ? Color.black : Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                .shadow(color: Color.black.opacity(0.2), radius: 7, x: 0, y: 2)
                
            }.padding()
        }
    }
}

struct InfoCards_Previews: PreviewProvider {
    static var previews: some View {
        InfoCards()
    }
}
