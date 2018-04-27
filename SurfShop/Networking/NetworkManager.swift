//
//  NetworkController.swift
//  SurfShop
//
//  Created by James Pacheco on 1/30/18.
//  Copyright © 2018 James Pacheco. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

class NetworkManager: Networking {
    private let scheme: String = "http"
    private let host: String = "localhost"
    private let port: Int = 8080
    
    func performTask(path: String, queryItems: [URLQueryItem]?=nil, method: HTTPMethod = .get, body: Data?=nil, headers: [String: String]?=nil, completion: @escaping (Data?) -> ()) {
        guard let url = createURL(path: path, queryItems: queryItems) else {
            fatalError("Make this work")
        }
        
        let request = buildURLRequest(url: url, method: method, body: body, headers: headers)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion(data)
        }.resume()
    }
}

extension NetworkManager {
    private func createURL(path: String, queryItems: [URLQueryItem]?) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.port = port
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
    
    private func buildURLRequest(url: URL, method: HTTPMethod, body: Data?, headers: [String: String]?) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        request.allHTTPHeaderFields = headers
        return request
    }
}

protocol Networking {
    func performTask(path: String, queryItems: [URLQueryItem]?, method: HTTPMethod, body: Data?, headers: [String: String]?, completion: @escaping (Data?) -> ())
}

extension Networking {
    func performTask(path: String, completion: @escaping (Data?) -> ()) {
        performTask(path: path, queryItems: nil, method: .get, body: nil, headers: nil, completion: completion)
    }
    
    func performTask(path: String, queryItems: [URLQueryItem], completion: @escaping (Data?) -> ()) {
        performTask(path: path, queryItems: queryItems, method: .get, body: nil, headers: nil, completion: completion)
    }
    
    func performTask(path: String, method: HTTPMethod, completion: @escaping (Data?) -> ()) {
        performTask(path: path, queryItems: nil, method: method, body: nil, headers: nil, completion: completion)
    }
    
    func performTask(path: String, body: Data, completion: @escaping (Data?) -> ()) {
        performTask(path: path, queryItems: nil, method: .get, body: body, headers: nil, completion: completion)
    }
    
    func performTask(path: String, headers: [String: String], completion: @escaping (Data?) -> ()) {
        performTask(path: path, queryItems: nil, method: .get, body: nil, headers: headers, completion: completion)
    }
    
    func performTask(path: String, queryItems: [URLQueryItem], method: HTTPMethod, completion: @escaping (Data?) -> ()) {
        performTask(path: path, queryItems: queryItems, method: method, body: nil, headers: nil, completion: completion)
    }
    
    func performTask(path: String, queryItems: [URLQueryItem], body: Data, completion: @escaping (Data?) -> ()) {
        performTask(path: path, queryItems: queryItems, method: .get, body: body, headers: nil, completion: completion)
    }
    
    func performTask(path: String, queryItems: [URLQueryItem], headers: [String: String], completion: @escaping (Data?) -> ()) {
        performTask(path: path, queryItems: queryItems, method: .get, body: nil, headers: headers, completion: completion)
    }
    
    func performTask(path: String, method: HTTPMethod, body: Data, completion: @escaping (Data?) -> ()) {
        performTask(path: path, queryItems: nil, method: method, body: body, headers: nil, completion: completion)
    }
    
    func performTask(path: String, method: HTTPMethod, headers: [String: String], completion: @escaping (Data?) -> ()) {
        performTask(path: path, queryItems: nil, method: method, body: nil, headers: headers, completion: completion)
    }
    
    func performTask(path: String, body: Data, headers: [String: String], completion: @escaping (Data?) -> ()) {
        performTask(path: path, queryItems: nil, method: .get, body: body, headers: headers,     completion: completion)
    }
    
    func performTask(path: String, queryItems: [URLQueryItem], method: HTTPMethod, body: Data, completion: @escaping (Data?) -> ()) {
        performTask(path: path, queryItems: queryItems, method: method, body: body, headers:     nil, completion: completion)
    }
    
    func performTask(path: String, queryItems: [URLQueryItem], method: HTTPMethod, headers: [String: String], completion: @escaping (Data?) -> ()) {
        performTask(path: path, queryItems: queryItems, method: method, body: nil, headers:     headers, completion: completion)
    }
    
    func performTask(path: String, queryItems: [URLQueryItem], body: Data, headers: [String:String], completion: @escaping (Data?) -> ()) {
        performTask(path: path, queryItems: queryItems, method: .get, body: body, headers: headers, completion: completion)
    }
    
    func performTask(path: String, method: HTTPMethod, body: Data, headers: [String: String], completion: @escaping (Data?) -> ()) {
        performTask(path: path, queryItems: nil, method: method, body: body, headers: headers, completion: completion)
    }

}










