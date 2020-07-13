//
//  Settings.swift
//  HealthMonitor
//
//  Created by Filippo Bartolucci on 13/07/2020.
//  Copyright © 2020 Filippo Bartolucci. All rights reserved.
//

import SwiftUI

struct Settings: View {
    @Environment(\.presentationMode) var presentationMode
    
    //@Binding var sheet: Bool
    @State var temperatureImportance = 0
    
    var body: some View {
        NavigationView{
            Form{Text("Here comes the sun")}
          
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
