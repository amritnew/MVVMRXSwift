//
//  RequestManager.swift
//  WunderAssignment
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
    
    /// session instance used to fetch data from remote server
    private var urlSession = URLSession(configuration: .default)
    
    
    /// get cars list from location url
    /// - Parameter success: completion block for handling success response, json will be deliver in this block
    /// - Parameter failure: completion block for handling failure response, this contains failure code and error type
    func getData(success: @escaping SuccessResponse, failure: @escaping FailureClosure) {
        
        let urlString = "https://wunder-test-case.s3-eu-west-1.amazonaws.com/ios/locations.json"
        self.getResponse(stringUrl: urlString) {(code, json, error) in
            if error == ErrorType.noError, let responseJson = json {
                
                do {
                    let newjson = responseJson[kPlacemarks] as? [[String : Any]]
                    let jsonData = try JSONSerialization.data(withJSONObject: newjson as Any, options: .fragmentsAllowed)
                    success(jsonData)
                }
                catch {
                    failure(0, ErrorType.dataParseError)
                }
                
            }
            else {
                failure(code, error)
            }
        }
    }
    
    //MARK: Private functions
    
    /// Create request , fetch data and parse data
    /// - Parameter stringUrl: Url to fetch remote data
    /// - Parameter completion: For handling the completion after  api response.
    private func getResponse(stringUrl: String, completion: @escaping Completion) {
        if let url = URL(string: stringUrl) {
            var urlRequest = URLRequest(url: url , cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
            urlRequest.httpMethod = HTTPMethod.get.rawValue
            
            urlSession.dataTask(with: urlRequest) { (data, response, error) in
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                var json: [String: Any]?
                if let responseData = data {
                    do {
                        json = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as? [String: Any]
                    }
                    catch {
                        completion(0,nil,ErrorType.dataParseError)
                    }
                    
                    if self.isSuccessCode(statusCode) {
                        completion(statusCode, json, ErrorType.noError)
                    }
                    else {
                        completion(statusCode, nil, ErrorType.connectionError)
                    }
                    
                }
                else {
                    completion(statusCode, nil, ErrorType.connectionError)
                }
            }.resume()
        }
        else {
            completion(0,nil,ErrorType.requestError)
        }
    }

    /// Basic handler for all type of requests
    /// - Parameter statusCode: HTTPURLResponse's status code for an API's response.
    /// - Returns: A 'Bool' value stating whether status code lies in success range or not (i.e. 200 - 299).
    private func isSuccessCode(_ statusCode: Int) -> Bool {
        return (statusCode > 199 && statusCode < 300)
    }
    
}

