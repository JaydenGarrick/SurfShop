//
//  Product.swift
//  SurfShop
//
//  Created by James Pacheco on 1/29/18.
//  Copyright © 2018 James Pacheco. All rights reserved.
//

import Foundation
import UIKit

struct Product: Codable {
    var id: String
    var name: String
    var description: String
    var price: Double
    var categoryId: Int
    var specs: [String]
    var sizes: [String]?
    var colors: [String]?
    var imageURL: String
    
    var shortDescription: String {
        return ""
    }
    
    var image: UIImage {
        return #imageLiteral(resourceName: "ProductDefault")
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, price, categoryId, sizes, colors, specs
        case imageURL = "image_url"
    }
}

extension Product: Hashable {
    var hashValue: Int {
        return id.hashValue
    }
    
    static func ==(lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
    
    
}
