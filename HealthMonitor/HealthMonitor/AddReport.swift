//
//  AddReport.swift
//  HealthMonitor
//
//  Created by Filippo Bartolucci on 12/07/2020.
//  Copyright © 2020 Filippo Bartolucci. All rights reserved.
//

import SwiftUI

struct AddReport: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var addingReport: Bool
    
    @State var temp: String
    @State var date = Date() // Current Date
    

    
    var body: some View {
        NavigationView {
            Form {
                TextField("Temperatura", text: $temp)
                .keyboardType(.numberPad)
            }
            .navigationBarTitle("New Report", displayMode: .inline)
                
            .navigationBarItems(trailing:Button(action: {
                self.presentationMode.wrappedValue.dismiss()
                
                
            }) {Text("Cancel")})
            
            
        }
    }
}

struct AddReport_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
