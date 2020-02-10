//
//  CarMapModel.swift
//  MVVMRXSwift
//
//  Created by AmritPandey on 16/12/19.
//  Copyright © 2019 Wunder. All rights reserved.
//

import Foundation
import CoreLocation


/// Store coordinates of car and name to show on map
struct CarMap {
    var coordinate: CLLocationCoordinate2D
    var name: String
}
