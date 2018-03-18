//
//  QuoteDetailsTests.swift
//  StockQuoteTests
//
//  Created by Thomas Ganley on 3/15/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import XCTest
@testable import StockQuote

class QuoteDetailsTests: XCTestCase {
    
    func test_WhenDecodingSampleJSON_QuotesDetailsIsCreated() {
        let bundle = Bundle(for: type(of: self))
        guard let sampleDataPath = bundle.path(forResource: "SampleStockDetail", ofType: "json") else { XCTFail(); return }
        
        var quote = Quote(symbol: "TEST", priceString: "123.45")
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: sampleDataPath)),
            let topJSON = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any],
            let timeSeries = topJSON["Time Series (1min)"] as? [String: Any],
            let details = timeSeries["2018-03-15 16:00:00"] as? [String: String]  else { XCTFail(); return }
        
        quote.update(withDetailsDict: details)
        
        XCTAssertEqual(quote.high, 94.33, accuracy: 0.01)
        XCTAssertEqual(quote.low, 94.17, accuracy: 0.01)
        XCTAssertEqual(quote.open, 94.26, accuracy: 0.01)
        XCTAssertEqual(quote.close, 94.18, accuracy: 0.01)
    }
}
