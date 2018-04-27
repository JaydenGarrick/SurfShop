//
//  MockNetworkManager.swift
//  SurfShopTests
//
//  Created by Jayden Garrick on 4/27/18.
//  Copyright © 2018 James Pacheco. All rights reserved.
//

import Foundation
@testable import SurfShop

class MockNetworkManager: Networking {
    
    // MARK: - Variables
    var dataToReturn: Data? // The data that is going to be returned
    var path: String?
    var queryItems: [URLQueryItem]?
    var method: HTTPMethod?
    var body: Data?
    var headers: [String:String]?
    
    func performTask(path: String, queryItems: [URLQueryItem]?, method: HTTPMethod, body: Data?, headers: [String: String]?, completion: @escaping (Data?) -> ()) {
        self.path = path
        self.queryItems = queryItems
        self.method = method
        self.body = body
        self.headers = headers
        completion(dataToReturn)
    }
    
}
