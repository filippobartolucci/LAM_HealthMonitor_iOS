//
//  Settings.swift
//  HealthMonitor
//
//  Created by Filippo Bartolucci on 13/07/2020.
//  Copyright © 2020 Filippo Bartolucci. All rights reserved.
//

import SwiftUI

struct preferences{
    
}

struct Settings: View {
    @Environment(\.presentationMode) var presentationMode
    
    //@Binding var sheet: Bool
    @State var temperatureImportance = 0
    @State var notifications = false
    @State var notificationTime = Date()
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Notifications Settings")){
                    Toggle(isOn: $notifications) {
                        Text("Enable notifications")
                    }
                    if notifications {
                        DatePicker("Time", selection: $notificationTime, displayedComponents: .hourAndMinute)
                    }
                }
                Section{
                    Text("Prova")
                }
            }
        
            .navigationBarTitle("Settings", displayMode: .inline)
            .navigationBarItems(leading:Button(action: {self.presentationMode.wrappedValue.dismiss()}){Text("Close")})
            
        }
        
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
