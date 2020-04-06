//
//  RequestManager.swift
//  MVVMRXSwift
//
//  Created by AmritPandey on 09/12/19.
//  Copyright © 2019 Wunder. All rights reserved.
//

import Foundation

protocol APIServiceProtocol {
    func getData(success: @escaping SuccessResponse, failure: @escaping FailureClosure)
}

/// Singleton class for data fetching task
class APIService: APIServiceProtocol {
    
    /// singleton instance
    static let shared = APIService()
    
    /// get cars list from location json file
    /// - Parameter success: completion block for handling success response, json will be deliver in this block
    /// - Parameter failure: completion block for handling failure response, this contains failure code and error type
    func getData(success: @escaping SuccessResponse, failure: @escaping FailureClosure) {
         
        guard let path = Bundle.main.path(forResource: "Location", ofType: "json") else { failure(0, ErrorType.unknownError)
            return
        }
        let url = URL(fileURLWithPath: path)
        do {
            let jsonData = try Data(contentsOf: url, options: .alwaysMapped)
            success(jsonData)
        }
        catch {
            failure(0, ErrorType.requestError)
        }
    }
    
}

