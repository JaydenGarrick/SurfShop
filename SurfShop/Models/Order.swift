//
//  ORder.swift
//  SurfShop
//
//  Created by James Pacheco on 1/30/18.
//  Copyright © 2018 James Pacheco. All rights reserved.
//

import Foundation

enum OrderState: String, Codable {
    case confirmed = "Confirmed"
    case processing = "Processing"
    case shipped = "Shipped"
    case delivered = "Delivered"
}

struct Order: Decodable {
    var id: String
    var accountId: String?
    var items: [ProductSelection]
    var orderDate: Date
    var tax: Double
    var subtotal: Double
    var total: Double
    var orderState: OrderState
    
    var description: String {
        var description = "\(items.first!.title)"
        if items.count > 1 {
            description += " & \(items.count - 1) more"
        }
        return description
    }
    
    enum CodingKeys: String, CodingKey {
        case id, items, subtotal, total, tax
        case accountId = "account_id"
        case orderDate = "date"
        case orderState = "order_state"
    }
}

extension Order: Equatable {
    static func ==(lhs: Order, rhs: Order) -> Bool {
        return lhs.id == rhs.id
    }
}
