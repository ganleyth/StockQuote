//
//  BatchQuotesTests.swift
//  StockQuoteTests
//
//  Created by Thomas Ganley on 3/13/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import XCTest
@testable import StockQuote

class BatchQuoteTests: XCTestCase {
    
    func test_WhenDecodingSampleJSON_BatchQuotesResponseIsCreated() {
        let bundle = Bundle(for: type(of: self))
        guard let sampleDataPath = bundle.path(forResource: "SampleBatchQuotesJSON", ofType: "json") else { XCTFail(); return }
        
        let batchQuotesResponse: BatchQuotesResponse
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: sampleDataPath))
            batchQuotesResponse = try JSONDecoder().decode(BatchQuotesResponse.self, from: data)
        } catch {
            print("Error converting sample JSON to Data: \(error.localizedDescription)")
            XCTFail()
            return
        }
        
        let quotes = batchQuotesResponse.quotes
        
        
        
    }
    
}

// private helpers
private extension BatchQuoteTests {
    
    func validate(quote: Quote, withSymbol symbol: String, andPrice price: Double) {
        
    }
    
    
}
