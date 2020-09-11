//
//  NavigationButton.swift
//  HealthMonitor_LAM
//
//  Created by Filippo Bartolucci on 09/09/2020.
//  Copyright © 2020 Filippo Bartolucci. All rights reserved.
//

import SwiftUI


struct NavigationButton: View {
    var imageName: String
    var text : String
    var colour: String
    
    var body: some View {
        boxView(content: AnyView(
            HStack{
                Image(systemName: self.imageName)
                Text(self.text)
                Spacer()
                Image(systemName: "arrow.right").accentColor(Color("text"))
            }.accentColor(Color(self.colour)).padding(.horizontal).frame(minWidth : widthBound,maxWidth:widthBound, minHeight: buttonHeight)
        )).padding(.horizontal)
    }
}
