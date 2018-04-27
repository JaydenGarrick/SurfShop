//
//  OrderTests.swift
//  SurfShopTests
//
//  Created by Jayden Garrick on 4/27/18.
//  Copyright © 2018 James Pacheco. All rights reserved.
//

import XCTest
@testable import SurfShop

class OrderTests: XCTestCase {
    
    func testCreatingOrderFromJSON() {
        guard let testProductSelection = try? JSONDecoder().decode(ProductSelection.self, from: productSelectionJSON) else {
            XCTFail("Could not decode JSON for the test ProductSelection object")
            return
        }
        
        guard let order = try? JSONDecoder().decode(Order.self, from: orderJSON) else {
            XCTFail("Could not decode order from JSON")
            return
        }
        
        XCTAssertEqual(order.items, [testProductSelection], "Order had incorrect items")
        XCTAssertEqual(order.subtotal, 899, accuracy: Double.ulpOfOne, "Order had incorrect subtotal")
        XCTAssertEqual(order.tax, 60.682500000000005, accuracy: Double.ulpOfOne, "Order had incorrect tax")
        XCTAssertEqual(order.total, 959.6825, accuracy: Double.ulpOfOne, "Order had incorrect total")
        XCTAssertEqual(order.orderDate.timeIntervalSinceReferenceDate, 540854542.05850506, accuracy: Double.ulpOfOne, "Order had incorrect date")
        XCTAssertEqual(order.orderState.rawValue, "Confirmed", "Order had incorrect state")

    }
    
}
