//
//  Extensions.swift
//  MVVMRXSwift
//
//  Created by AmritPandey on 16/12/19.
//  Copyright © 2019 Wunder. All rights reserved.
//

import Foundation
import  CoreLocation

extension CLLocationCoordinate2D: Equatable {
    
    /// Compare two coordinates, Return Bool for result
    /// - Parameter lhs: coordinate instance
    /// - Parameter rhs: coordinate instance
    static public func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
