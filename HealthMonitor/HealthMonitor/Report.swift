//
//  Report.swift
//  HealthMonitor
//
//  Created by Filippo Bartolucci on 12/07/2020.
//  Copyright © 2020 Filippo Bartolucci. All rights reserved.
//

import Foundation

struct Report: Hashable, Codable, Identifiable{
    let id = UUID()
    let date : Date 
    var temperature : Float
    var weight : Float
    var note = ""
}
