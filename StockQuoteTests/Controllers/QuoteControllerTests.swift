//
//  QuoteControllerTests.swift
//  StockQuoteTests
//
//  Created by Thomas Ganley on 3/14/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import XCTest
@testable import StockQuote

class QuoteControllerTests: XCTestCase {
    
    var sut: QuoteController {
        return QuoteController.shared
    }
    
    func test_WhenFetchingBatchQuotes_QuotesAreStored() {
        let bundle = Bundle(for: type(of: self))
        guard let sampleDataPath = bundle.path(forResource: "SampleBatchQuotesJSON", ofType: "json") else { XCTFail(); return }
        let data = try? Data(contentsOf: URL(fileURLWithPath: sampleDataPath))
        
        let networkController = MockNetworkController(data: data, error: nil)
        sut.networkController = networkController
        
        let expection = XCTestExpectation()
        sut.fetchBatchQuotes(forSymbols: ["MSFT", "FB", "AAPL"]) {
            XCTAssertNotNil(self.sut.quotes?.index(where: { $0.symbol == "MSFT" }))
            XCTAssertNotNil(self.sut.quotes?.index(where: { $0.symbol == "FB" }))
            XCTAssertNotNil(self.sut.quotes?.index(where: { $0.symbol == "AAPL" }))
            expection.fulfill()
        }
        
        wait(for: [expection], timeout: 1.0)
    }
    
    func test_WhenFetchingStockDetails_ProperStockIsReturned() {
        let bundle = Bundle(for: type(of: self))
        guard let sampleDataPath = bundle.path(forResource: "SampleStockDetail", ofType: "json") else { XCTFail(); return }
        let data = try? Data(contentsOf: URL(fileURLWithPath: sampleDataPath))
        
        let networkController = MockNetworkController(data: data, error: nil)
        sut.networkController = networkController
        
        let quote = Quote(symbol: "MSFT", priceString: "94.23")
        
        let expectation = XCTestExpectation()
        sut.fetchQuoteDetails(for: quote) { (updatedQuote) in
            XCTAssertEqual(updatedQuote.high, 94.33, accuracy: 0.01)
            XCTAssertEqual(updatedQuote.low, 94.17, accuracy: 0.01)
            XCTAssertEqual(updatedQuote.open, 94.26, accuracy: 0.01)
            XCTAssertEqual(updatedQuote.close, 94.18, accuracy: 0.01)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
}

extension QuoteControllerTests {
    
    class MockNetworkController: NetworkControllerProtocol {
        
        private let data: Data?
        private let error: Error?
        
        init(data: Data?, error: Error?) {
            self.data = data
            self.error = error
        }
        
        func performGETRequest(for url: URL, completion: @escaping (Data?, Error?) -> Void) {
            completion(data, error)
        }
        
        func url(byAdding params: [String: String]?, to baseURL: URL) -> URL? {
            return URL(string: "https://testURL.com")
        }
    }
}
