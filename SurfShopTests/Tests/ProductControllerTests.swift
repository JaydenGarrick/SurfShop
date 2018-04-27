//
//  ProductControllerTests.swift
//  SurfShopTests
//
//  Created by Jayden Garrick on 4/27/18.
//  Copyright © 2018 James Pacheco. All rights reserved.
//

import XCTest
@testable import SurfShop

class ProductControllerTests: XCTestCase {
    
    var mockNetworkManager: MockNetworkManager!
    var productController: ProductController!
    
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        productController = ProductController(network: mockNetworkManager)
    }

    
    // MARK: - Test 'getCategories' method
    func testGetCategoriesPassesCorrectURLInfo() {
        let expectation = self.expectation(description: "Get category array")
        
        productController.getCategories { (_) in
            XCTAssertEqual("/categories", self.mockNetworkManager.path ?? "", "Incorrect path")
                XCTAssertEqual(HTTPMethod.get, self.mockNetworkManager.method, "Incorrect method")
            XCTAssertNil(self.mockNetworkManager.queryItems, "There were queries included")
            XCTAssertNil(self.mockNetworkManager.body, "There was a body included")
            XCTAssertNil(self.mockNetworkManager.headers, "There were headers included")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testGetCategoriesReturnsNonEmptyArrayFromValidData() {
        mockNetworkManager.dataToReturn = categoryArrayJSON
        
        let expectation = self.expectation(description: "Get category array")
        
        productController.getCategories { (categories) in
            XCTAssertNotEqual(categories, [], "Object returned was an empty array")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetCategoriesReturnsEmptyArrayFromNilData() {
        
        let expectation = self.expectation(description: "Get empty array from nil data")
        
        productController.getCategories { (categories) in
            XCTAssertEqual(categories, [], "Array did not return empty")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetCategoriesReutnsEmptyArrayFromInvalidData() {
        mockNetworkManager.dataToReturn = Data()
        
        let expectation = self.expectation(description: "Get empty array from invalid data")
        
        productController.getCategories { (categories) in
            XCTAssertEqual(categories, [], "Array did not return empty when invalid data was passed")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    
    // MARK: - Test 'getProduct' method
    func testGetProductPassesCorrectURLInfo() {
        let category = Category(id: 1, name: "Test")
        
        let expectation = self.expectation(description: "Get category array")
        
        productController.getProducts(for: category) { (_) in
            XCTAssertEqual("/products", self.mockNetworkManager.path ?? "", "Incorrect path")
            XCTAssertEqual(HTTPMethod.get, self.mockNetworkManager.method, "Incorrect method")
            XCTAssertTrue(self.mockNetworkManager.queryItems?.contains(URLQueryItem(name: "category", value: category.id.description)) ?? false, "category not included as query")
            XCTAssertNil(self.mockNetworkManager.body, "There was a body included")
            XCTAssertNil(self.mockNetworkManager.headers, "There were headers included")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetProductReturnsCorrectItemFromValidData() {
        let category = Category(id: 1, name: "Test")
        mockNetworkManager.dataToReturn = productArrayJSON
        
        let expectation = self.expectation(description: "Get products")
        
        productController.getProducts(for: category) { (products) in
            XCTAssertNotEqual(products, [], "The products returned were not an empty array")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetProductReturnsNilFromNilData() {
        let category = Category(id: 1, name: "Test")
        
        let expectation = self.expectation(description: "Get empty array from nil data")
        
        productController.getProducts(for: category) { (products) in
            XCTAssertEqual(products, [], "The nil data returned not an empty array")
            
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetProductReturnsNilFromInvalidData() {
        mockNetworkManager.dataToReturn = Data()
        
        let category = Category(id: 1, name: "Test")
        
        let expectation = self.expectation(description: "Get empty array from nil data")
        
        productController.getProducts(for: category) { (products) in
            XCTAssertEqual(products, [], "The nil data returned not an empty array")
            
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    
    // MARK: - Test 'getProducts' method
    func testGetProductsPassesCorrectURLInfo() {
        let expectation = self.expectation(description: "get product")
        
        productController.getProduct(for: "Test") { (_) in
            XCTAssertEqual("/products", self.mockNetworkManager.path ?? "", "Incorrect path")
            XCTAssertEqual(HTTPMethod.get, self.mockNetworkManager.method, "Incorrect method")
            XCTAssertNil(self.mockNetworkManager.body, "There was a body included")
            XCTAssertNil(self.mockNetworkManager.headers, "There were headers included")

            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetProductsReturnsCorrectItemFromValidData() {
        mockNetworkManager.dataToReturn = productJSON
        let expectation = self.expectation(description: "get product from valid data")
        
        productController.getProduct(for: "Test") { (product) in
            XCTAssertNotNil(product)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetProductReturnsEmptyArrayFromNilData() {
        let expectation = self.expectation(description: "get nil product from nil data")
        
        productController.getProduct(for: "Test") { (product) in
            XCTAssertEqual(product, nil)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetProductReturnsEmptyArrayFromInvalidData() {
        let expectation = self.expectation(description: "get nil product from nil data")
        mockNetworkManager.dataToReturn = Data()
        
        productController.getProduct(for: "Test") { (product) in
            XCTAssertEqual(product, nil)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
