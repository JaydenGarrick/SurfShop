//
//  BagTests.swift
//  SurfShopTests
//
//  Created by Jayden Garrick on 4/27/18.
//  Copyright © 2018 James Pacheco. All rights reserved.
//

import XCTest

import XCTest
@testable import SurfShop

class BagTests: XCTestCase {
    
    func testCreatingBagFromJSON() {
        guard let testProductSelection = try? JSONDecoder().decode(ProductSelection.self, from: productSelectionJSON) else {
            XCTFail("Could not decode JSON for the test ProductSelection object")
            return
        }
        
        guard let bag = try? JSONDecoder().decode(Bag.self, from: bagJSON) else {
            XCTFail("Could not decode bag JSON")
            return
        }
        
        XCTAssertEqual(bag.items, [testProductSelection], "Bag had incorrect items")
        XCTAssertEqual(bag.estimatedTax, 60.682500000000005, accuracy: Double.ulpOfOne, "Bag had incorrect estimated tax")
        XCTAssertEqual(bag.id, "CA1CC8DC-24F1-46DC-8513-441A50DE326B", "Bag had incorrect ID")
        XCTAssertEqual(bag.subtotal, 899, accuracy: Double.ulpOfOne, "Bag had incorrect subtotal")
        XCTAssertEqual(bag.total, 959.6825, accuracy: Double.ulpOfOne, "Bag had incorrect total")
    }
    
}
