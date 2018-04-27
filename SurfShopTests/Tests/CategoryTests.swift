//
//  CategoryTests.swift
//  SurfShopTests
//
//  Created by Jayden Garrick on 4/27/18.
//  Copyright © 2018 James Pacheco. All rights reserved.
//

import XCTest
@testable import SurfShop

class CategoryTests: XCTestCase {
    
    func testCreatingCategoryFromJSON() {
        guard let category = try? JSONDecoder().decode(Category.self, from: categoryJSON) else {
            XCTFail("Unable to decode category JSON")
            return
        }
        
        XCTAssertEqual(category.id, 1, "Category had wrong ID")
        XCTAssertEqual(category.name, "Accessories", "Category had incorrect name")
    }
    
    
}
