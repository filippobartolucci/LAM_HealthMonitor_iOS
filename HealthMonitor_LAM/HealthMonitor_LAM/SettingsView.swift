//
//  SettingsView.swift
//  HealthMonitor_LAM
//
//  Created by Filippo Bartolucci on 13/08/2020.
//  Copyright © 2020 Filippo Bartolucci. All rights reserved.
//

import SwiftUI
import CoreData


struct SettingsView: View {
    @State var notifications: Bool = false
    
    @State var notificationManager = LocalNotificationManager()
    
    
    var body: some View {
        ScrollView{
            boxView(content: AnyView(
                HStack{
                    Button(action: {self.notificationManager.removePendingNotification()}){
                        Text("Set daily reminder")
                    }.frame(minHeight: buttonHeight)
                    Spacer()
                }.padding(.horizontal)
            ))
            }.accentColor(Color("text")).navigationBarTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
