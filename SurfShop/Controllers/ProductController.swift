//
//  ProductController.swift
//  SurfShop
//
//  Created by James Pacheco on 1/30/18.
//  Copyright © 2018 James Pacheco. All rights reserved.
//

import Foundation

class ProductController {
    private let network: Networking
    static let shared = ProductController(network: NetworkManager())
    
    init(network: Networking) {
        self.network = network
    }
    
    func getCategories(completion: @escaping ([Category]) -> ()) {
        network.performTask(path: "/categories") { (data) in
            let jsonDecoder = JSONDecoder()
            DispatchQueue.main.async {
                if let data = data {
                    completion((try? jsonDecoder.decode([Category].self, from: data)) ?? [])
                } else {
                    completion([])
                }
            }
        }
    }
    
    func getProducts(for category: Category, completion: @escaping ([Product]) -> ()) {
        let urlQuery = URLQueryItem(name: "category", value: String(category.id))
        network.performTask(path: "/products", queryItems: [urlQuery]) { (data) in
            let jsonDecoder = JSONDecoder()
            DispatchQueue.main.async {
                if let data = data {
                    completion((try? jsonDecoder.decode([Product].self, from: data)) ?? [])
                } else {
                    completion([])
                }
            }
        }
    }
    
    func getProduct(for id: String, completion: @escaping (Product?) -> ()) {
        let urlQuery = URLQueryItem(name: "id", value: id)
        network.performTask(path: "/products", queryItems: [urlQuery]) { (data) in
            let jsonDecoder = JSONDecoder()
            DispatchQueue.main.async {
                if let data = data {
                    completion(try? jsonDecoder.decode(Product.self, from: data))
                } else {
                    completion(nil)
                }
            }
        }
    }
}
