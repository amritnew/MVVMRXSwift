//
//  CarListModel.swift
//  WunderAssignment
//
//  Created by AmritPandey on 09/12/19.
//  Copyright © 2019 Wunder. All rights reserved.
//

import Foundation

/// Store information about car, Coadable to support Json decoding
struct Car: Codable {
    var address: String
    var coordinates: [Float]
    var engineType: String?
    var exterior: String
    var fuel: Int
    var interior: String
    var name: String
    var vin: String
}


