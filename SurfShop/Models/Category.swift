//
//  Category.swift
//  SurfShop
//
//  Created by James Pacheco on 1/30/18.
//  Copyright © 2018 James Pacheco. All rights reserved.
//

import Foundation
import UIKit

struct Category: Decodable {
    var id: Int
    var name: String
    var image: UIImage {
        return #imageLiteral(resourceName: "Hoodie")
    }
}

extension Category: Equatable {
    static func ==(lhs: Category, rhs: Category) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}
