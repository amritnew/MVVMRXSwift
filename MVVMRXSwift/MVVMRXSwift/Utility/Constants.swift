//
//  Constants.swift
//  MVVMRXSwift
//
//  Created by AmritPandey on 09/12/19.
//  Copyright © 2019 Wunder. All rights reserved.
//

import Foundation

let kCarMapViewIdentifier = "CarMap"
let kCellIdentifier = "CarListIdentifier"
let kAnnotIdentifier = "AnnotationIdentifier"
let kPlacemarks = "placemarks"
let kErrorTitle = "Error"
let kOkayTitle = "Ok"

typealias Completion = (_ code: Int, _ response: [String: Any]?, _ error: ErrorType) -> Void
typealias FailureClosure = (_ code: Int, _ error: ErrorType) -> Void
typealias SuccessResponse = (_ response: Data) -> Void
