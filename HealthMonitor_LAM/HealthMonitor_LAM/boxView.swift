//
//  boxView.swift
//  HealthMonitor_LAM
//
//  Created by Filippo Bartolucci on 12/08/2020.
//  Copyright © 2020 Filippo Bartolucci. All rights reserved.
//

import SwiftUI

struct boxView: View {
    @Environment(\.colorScheme) var colorScheme
    var content : AnyView
    
    var body : some View {
        Group{
            self.content
        }
            .frame(maxWidth : UIScreen.main.bounds.size.width*0.9)
            .background(Color("boxBackground"))
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        }
}
