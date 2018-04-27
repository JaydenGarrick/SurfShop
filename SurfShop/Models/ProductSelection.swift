//
//  SelectedProduct.swift
//  SurfShop
//
//  Created by James Pacheco on 2/14/18.
//  Copyright © 2018 James Pacheco. All rights reserved.
//

import Foundation

struct ProductSelection: Codable {
    var product: Product
    var size: String?
    var color: String?
    var quantity: Int
    
    var description: String? {
        var description = ""
        if let size = size {
            description = size
        }
        if let color = color {
            if description.count == 0 {
                description = color
            } else {
                description += ", \(color)"
            }
        }
        return description.count == 0 ? nil : description
    }
    
    var title: String {
        return product.name
    }
    
    var price: Double {
        return product.price * Double(quantity)
    }
    
    var formattedQuantity: String {
        return "QTY \(quantity)"
    }
}

extension ProductSelection: Hashable {
    var hashValue: Int {
        return product.hashValue ^ (size?.hashValue ?? 0) ^ (color?.hashValue ?? 0)
    }
    
    static func ==(lhs: ProductSelection, rhs: ProductSelection) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
