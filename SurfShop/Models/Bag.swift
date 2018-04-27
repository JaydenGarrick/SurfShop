//
//  Bag.swift
//  SurfShop
//
//  Created by James Pacheco on 1/30/18.
//  Copyright © 2018 James Pacheco. All rights reserved.
//

import Foundation

struct Bag: Decodable {
    var id: String
    var items: [ProductSelection]
    var estimatedTax: Double
    var total: Double
    var subtotal: Double
    
    enum CodingKeys: String, CodingKey {
        case items, total, subtotal, id
        case estimatedTax = "est_tax"
    }
}

extension Bag: Equatable {
    static func ==(lhs: Bag, rhs: Bag) -> Bool {
        return lhs.id == rhs.id && lhs.items == rhs.items && lhs.estimatedTax == rhs.estimatedTax && lhs.total == rhs.total && lhs.subtotal == rhs.subtotal
    }
}
