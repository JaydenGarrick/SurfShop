//
//  ProductTests.swift
//  SurfShopTests
//
//  Created by Jayden Garrick on 4/27/18.
//  Copyright © 2018 James Pacheco. All rights reserved.
//

import XCTest
@testable import SurfShop

class ProductTests: XCTestCase {
    
    func testCreatingProductFromJSON() {
        guard let product = try? JSONDecoder().decode(Product.self, from: productJSON) else {
            XCTFail("Product JSON could not be decoded into a Product object")
            return
        }
        XCTAssertEqual(product.name, "Slim Flip Flop", "Product had incorrect name")
        XCTAssertEqual(product.description,
                       "For simple and classic summer style, stick with these flip flops. This perfect flip flop has a molded thin rubber upper, a shock absorbing midsole, and a durable rubber outsole for premium footing. Hit the beach in style this summer.",
                       "Product had incorrect description")
        XCTAssertEqual(product.sizes ?? [], ["5", "6", "7", "8", "9", "10", "11", "12", "13"], "Product had wrong sizes")
        XCTAssertEqual(product.specs,
                       ["Model Number: SANDAL-2400",
                        "Dimensions: 14 x 5 x 5",
                        "Weight: 5 oz",
                        "Material: Rubber"],
                       "Product had incorrect specs")
        XCTAssertEqual(product.categoryId, 7, "Product had incorrect category ID")
        XCTAssertEqual(product.price, 2700, "Product had incorrect price")
        XCTAssertEqual(product.imageURL, "http://localhost:8090/images/slim-flip-flop", "Product had incorrect image url")
        XCTAssertEqual(product.id, "584337500384", "Product had incorrect ID")
        XCTAssertNil(product.colors)
    }
    
}
