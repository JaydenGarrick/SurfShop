//
//  CheckoutController.swift
//  SurfShop
//
//  Created by James Pacheco on 1/30/18.
//  Copyright © 2018 James Pacheco. All rights reserved.
//

import Foundation

class CheckoutController {
    private let network = NetworkManager()
    private var bag: Bag?
    
    static let shared = CheckoutController()
    
    func addToBag(productSelection: ProductSelection, bag: Bag? = nil, completion: @escaping (Bag?) -> ()) {
        add(productSelection: productSelection, to: bag, completion: completion)
    }
    
    func empty(bag: Bag, completion: @escaping (Bag?) -> ()) {
        let queryItems = [URLQueryItem(name: "id", value: bag.id)]
        
        network.performTask(path: "/empty-bag", queryItems: queryItems, method: .post) { (data) in
            let jsonDecoder = JSONDecoder()
            DispatchQueue.main.async {
                if let data = data {
                    completion(try? jsonDecoder.decode(Bag.self, from: data))
                } else {
                    completion(nil)
                }
            }
        }
    }
    
    func checkout(with bag: Bag, completion: @escaping (Order?) -> ()) {
        let queryItems = [URLQueryItem(name: "bag", value: bag.id)]
        
        network.performTask(path: "/checkout", queryItems: queryItems, method: .post) { (data) in
            let jsonDecoder = JSONDecoder()
            DispatchQueue.main.async {
                if let data = data {
                    self.bag = nil
                    completion(try? jsonDecoder.decode(Order.self, from: data))
                } else {
                    completion(nil)
                }
            }
        }
    }
    
    func getCurrentBag(completion: @escaping (Bag) -> ()) {
        if let bag = bag {
            completion(bag)
            return
        }
        
        add(productSelection: nil) { (bag) in
            guard let bag = bag else {
                fatalError("Something went wrong and a bag was not returned from the server")
            }
            self.bag = bag
            completion(bag)
        }
    }

    private func add(productSelection: ProductSelection?, to bag: Bag? = nil, completion: @escaping (Bag?) -> ()) {
        var queryItems: [URLQueryItem] = []
        
        if let productSelection = productSelection {
            queryItems = [
                URLQueryItem(name: "product", value: productSelection.product.id),
                URLQueryItem(name: "quantity", value: String(productSelection.quantity)),
                URLQueryItem(name: "size", value: productSelection.size),
                URLQueryItem(name: "color", value: productSelection.color)
            ]
        }
        
        let bag = bag ?? self.bag
        if let bag = bag {
            queryItems.append(URLQueryItem(name: "bag", value: bag.id))
        }
        
        network.performTask(path: "/add-item", queryItems: queryItems, method: .post) { (data) in
            let jsonDecoder = JSONDecoder()
            var bag: Bag? = nil
            if let data = data {
                bag = try? jsonDecoder.decode(Bag.self, from: data)
            }
            self.bag = bag
            DispatchQueue.main.async {
                completion(bag)
            }
        }
    }
    
}

