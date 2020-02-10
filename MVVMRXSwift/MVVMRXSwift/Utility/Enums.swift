//
//  Enums.swift
//  MVVMRXSwift
//
//  Created by AmritPandey on 13/12/19.
//  Copyright © 2019 Wunder. All rights reserved.
//

import Foundation

/// Type of Error we may encounter in our application
enum ErrorType: String {
    case noError = ""
    case noInternet = "Internet connection not available"
    case unknownError = "Unable to load list"
    case requestError = "Unable to request data"
    case connectionError = "Unable to get data from server"
    case dataParseError = "Unable to get correct Data"
}

/// Type of HTTPMethods
enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
}
