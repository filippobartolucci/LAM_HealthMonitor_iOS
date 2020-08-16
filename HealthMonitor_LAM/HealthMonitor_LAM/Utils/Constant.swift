//
//  constant.swift
//  HealthMonitor_LAM
//
//  Created by Filippo Bartolucci on 12/08/2020.
//  Copyright © 2020 Filippo Bartolucci. All rights reserved.
//

import Foundation
import SwiftUI
import SwiftUICharts

let tabIconSize : CGFloat = 24.0
let buttonHeight : CGFloat = 50
let rowHeight : CGFloat = 55
let graphHeight : CGFloat = 350
let widthBound : CGFloat = UIScreen.main.bounds.size.width*0.9
let squareSize : CGFloat = UIScreen.main.bounds.size.width*0.9*0.5


// Chart 
func tempStyle() -> ChartStyle {
    let styleTemp = ChartStyle(backgroundColor: Color("boxBackground"), accentColor: Color("lightBlue"), gradientColor: GradientColor(start: Color("lightBlue"), end: Color(.blue)), textColor: Color("text"), legendTextColor: Color("text"), dropShadowColor: Color("Text"))
    styleTemp.darkModeStyle = styleTemp
    
    return styleTemp
}

func weightStyle() -> ChartStyle {
    let styleW = ChartStyle(backgroundColor: Color("boxBackground"), accentColor: Color("purple"), gradientColor: GradientColor(start: Color("purple"), end: Color(.purple)), textColor: Color("text"), legendTextColor: Color("text"), dropShadowColor: Color("Text"))
    styleW.darkModeStyle = styleW
    
    return styleW
}

func heartStyle() -> ChartStyle {
    let styleH = ChartStyle(backgroundColor: Color("boxBackground"), accentColor: Color("purple"), gradientColor: GradientColor(start: Color("red"), end: Color(.red)), textColor: Color("text"), legendTextColor: Color("text"), dropShadowColor: Color("Text"))
    styleH.darkModeStyle = styleH
    
    return styleH
}

func glycemiaStyle() -> ChartStyle {
    let styleH = ChartStyle(backgroundColor: Color("boxBackground"), accentColor: Color("greenBlue"), gradientColor: GradientColor(start: Color("greenBlue"), end: Color(.cyan)), textColor: Color("text"), legendTextColor: Color("text"), dropShadowColor: Color("Text"))
    styleH.darkModeStyle = styleH
    
    return styleH
}
