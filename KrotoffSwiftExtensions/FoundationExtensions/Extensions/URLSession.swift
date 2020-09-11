//
//  URLSession.swift
//  MyFoundationExtensions
//
//  Created by Andrew Krotov on 15.07.2020.
//  Copyright © 2020 Andrew Krotov. All rights reserved.
//

import Foundation

public extension URLSession {
    
    // MARK: - Public types
    
    enum Method: String {
        case get = "GET"
        case delete = "DELETE"
        case patch = "PATCH"
        case post = "POST"
        case put = "PUT"
    }
    
    // MARK: - Public methods
    
    func sendRequest(
        url: URL,
        method: Method = .get,
        parameters: [String: Any] = [:],
        headers: [String: String]? = nil,
        responseHandler: @escaping ((Data?, URLResponse?, Error?) -> Void)
    ) {
        var urlRequest = URLRequest(url: url.appendingPathComponent(parameters.isEmpty ? "" : ("?" + parameters.queryString)))
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        
        dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async { responseHandler(data, response, error) }
        }.resume()
    }
}
