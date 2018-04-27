//
//  CheckoutControllerTests.swift
//  SurfShopTests
//
//  Created by Jayden Garrick on 4/27/18.
//  Copyright © 2018 James Pacheco. All rights reserved.
//

import XCTest
@testable import SurfShop

class CheckoutControllerTests: XCTestCase {
    
    var mockNetworkController: MockNetworkManager!
    var checkoutController: CheckoutController!
    var testProduct: Product!
    var testProductSelection: ProductSelection!
    var testBag: Bag!


    override func setUp() {
        super.setUp()
        mockNetworkController = MockNetworkManager()
        checkoutController = CheckoutController(network: mockNetworkController)
        checkoutController = CheckoutController(network: mockNetworkController)
        testProduct = Product(id: "test", name: "test", description: "test description", price: 9.99, categoryId: 1, specs: ["test specs"], sizes: ["S", "M"], colors: ["Green"], imageURL: "")
        testProductSelection = ProductSelection(product: testProduct, size: "M", color: "Green", quantity: 1)
        testBag = Bag(id: "1", items: [testProductSelection], estimatedTax: 1, total: 2, subtotal: 1)
    }
    
    // MARK: - `addToBag` method
    func testAddToEmptyBagPassesCorrectURLInfo() {
        let expectation = self.expectation(description: "Add product to bag")
        checkoutController.addToBag(productSelection: testProductSelection) { (_) in
            XCTAssertEqual(self.mockNetworkController.path ?? "", "/add-item", "Incorrect path")
            XCTAssertEqual(HTTPMethod.post, self.mockNetworkController.method, "Incorrect method")
            XCTAssertTrue(self.mockNetworkController.queryItems?.contains(URLQueryItem(name: "product", value: self.testProductSelection.product.id)) ?? false, "product wasn't included as a query item")
            XCTAssertTrue(self.mockNetworkController.queryItems?.contains(URLQueryItem(name: "quantity", value: self.testProductSelection.quantity.description)) ?? false, "quantity wasn't included as a query item")
            XCTAssertTrue(self.mockNetworkController.queryItems?.contains(URLQueryItem(name: "size", value: self.testProductSelection.size)) ?? false, "size wasn't included as a query item")
            XCTAssertTrue(self.mockNetworkController.queryItems?.contains(URLQueryItem(name: "color", value: self.testProductSelection.color)) ?? false, "color wasn't included as a query item")
            XCTAssertEqual(self.mockNetworkController.queryItems?.count, 4, "The number of query items was off")
            XCTAssertNil(self.mockNetworkController.body, "There was a body included")
            XCTAssertNil(self.mockNetworkController.headers, "There was a header included")
            
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testAddToExistingBagPassesCorrectURLInfo() {
        let expectation = self.expectation(description: "Add product to bag")
        
        checkoutController.addToBag(productSelection: testProductSelection, bag: testBag) { (_) in
            XCTAssertEqual(self.mockNetworkController.path ?? "", "/add-item", "Incorrect path")
            
            XCTAssertEqual(HTTPMethod.post, self.mockNetworkController.method, "Incorrect method")
            
            XCTAssertTrue(self.mockNetworkController.queryItems?.contains(URLQueryItem(name: "product", value: self.testProductSelection.product.id)) ?? false, "product wasn't included as a query")
            XCTAssertTrue(self.mockNetworkController.queryItems?.contains(URLQueryItem(name: "quantity", value: self.testProductSelection.quantity.description)) ?? false, "quantity wasn't included as a query")
            XCTAssertTrue(self.mockNetworkController.queryItems?.contains(URLQueryItem(name: "size", value: self.testProductSelection.size)) ?? false, "size wasn't included as a query")
            XCTAssertTrue(self.mockNetworkController.queryItems?.contains(URLQueryItem(name: "color", value: self.testProductSelection.color)) ?? false, "color wasn't included as a query")
            XCTAssertTrue(self.mockNetworkController.queryItems?.contains(URLQueryItem(name: "bag", value: self.testBag.id)) ?? false, "bag wasn't included as a query")
            XCTAssertEqual(self.mockNetworkController.queryItems?.count, 5, "The number of query items was off")
            
            XCTAssertNil(self.mockNetworkController.body, "There was a body included")
            
            XCTAssertNil(self.mockNetworkController.headers, "There was a header included")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testAddToBagReturnsBagFromValidData() {
        mockNetworkController.dataToReturn = bagJSON
        
        let expectation = self.expectation(description: "Add product to bag")
        
        checkoutController.addToBag(productSelection: testProductSelection) { (bag) in
            XCTAssertNotNil(bag, "The bag returned was nil")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testAddToBagReturnsNilFromNilData() {
        mockNetworkController.dataToReturn = nil
        
        let expectation = self.expectation(description: "Add product to bag")
        
        checkoutController.addToBag(productSelection: testProductSelection) { (bag) in
            XCTAssertNil(bag, "The bag returned was not nil")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testAddToBagReturnsNilFromInvalidData() {
        mockNetworkController.dataToReturn = Data()
        
        let expectation = self.expectation(description: "Add product to bag")
        
        checkoutController.addToBag(productSelection: testProductSelection) { (bag) in
            XCTAssertNil(bag, "The bag returned was not nil")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    // MARK: - Test `emptyBag` method
    func testEmptyBagPassesCorrectURLInfo() {
        let expectation = self.expectation(description: "Empty bag")
        
        checkoutController.empty(bag: testBag) { (_) in
            XCTAssertEqual(self.mockNetworkController.path ?? "", "/empty-bag", "Incorrect path")
            
            XCTAssertEqual(HTTPMethod.post, self.mockNetworkController.method, "Incorrect method")
            
            XCTAssertTrue(self.mockNetworkController.queryItems?.contains(URLQueryItem(name: "id", value: self.testBag.id)) ?? false, "id was not included as a query")
            XCTAssertEqual(self.mockNetworkController.queryItems?.count, 1, "The number of query items was off")
            
            XCTAssertNil(self.mockNetworkController.body, "There was a body included")
            
            XCTAssertNil(self.mockNetworkController.headers, "There was a header included")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testEmptyBagReturnsBagFromValidData() {
        mockNetworkController.dataToReturn = bagJSON
        
        let expectation = self.expectation(description: "Empty bag")
        
        checkoutController.empty(bag: testBag) { (bag) in
            XCTAssertNotNil(bag, "The bag returned was nil")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testEmptyBagReturnsNilFromNilData() {
        mockNetworkController.dataToReturn = nil
        
        let expectation = self.expectation(description: "Empty bag")
        
        checkoutController.empty(bag: testBag) { (bag) in
            XCTAssertEqual(nil, bag, "The bag returned was not nil")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testEmptyBagReturnsNilFromInvalidData() {
        mockNetworkController.dataToReturn = Data()
        
        let expectation = self.expectation(description: "Empty bag")
        
        checkoutController.empty(bag: testBag) { (bag) in
            XCTAssertNil(bag, "The bag returned was not nil")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    // MARK: - Test `checkout` method
    func testCheckoutPassesCorrectURLInfo() {
        let expectation = self.expectation(description: "Checkout")
        
        checkoutController.checkout(with: testBag) { (_) in
            XCTAssertEqual(self.mockNetworkController.path ?? "", "/checkout", "Incorrect path")
            
            XCTAssertEqual(HTTPMethod.post, self.mockNetworkController.method, "Incorrect method")
            
            XCTAssertTrue(self.mockNetworkController.queryItems?.contains(URLQueryItem(name: "bag", value: self.testBag.id)) ?? false, "bag was not included as a query")
            XCTAssertEqual(self.mockNetworkController.queryItems?.count, 1, "The number of query items was off")
            
            XCTAssertNil(self.mockNetworkController.body, "There was a body included")
            
            XCTAssertNil(self.mockNetworkController.headers, "There was a header included")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testCheckoutReturnsOrderFromValidData() {
        mockNetworkController.dataToReturn = orderJSON
        
        let expectation = self.expectation(description: "Checkout")
        
        checkoutController.checkout(with: testBag) { (order) in
            XCTAssertNotNil(order, "The order returned was nil")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testCheckoutReturnsNilFromNilData() {
        mockNetworkController.dataToReturn = nil
        
        let expectation = self.expectation(description: "Checkout")
        
        checkoutController.checkout(with: testBag) { (order) in
            XCTAssertNil(order, "The order returned was not nil")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testCheckoutReturnsNilFromInvalidData() {
        mockNetworkController.dataToReturn = Data()
        
        let expectation = self.expectation(description: "Checkout")
        
        checkoutController.checkout(with: testBag) { (order) in
            XCTAssertNil(order, "The order returned was not nil")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

}
