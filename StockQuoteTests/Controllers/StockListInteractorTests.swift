//
//  StockListInteractorTests.swift
//  StockQuoteTests
//
//  Created by Thomas Ganley on 3/15/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import XCTest
@testable import StockQuote

class StockListInteractorTests: XCTestCase {
    
    func test_InteractorUsesBatchQuotesDataForRowCount() {
        let bundle = Bundle(for: type(of: self))
        guard let sampleDataPath = bundle.path(forResource: "SampleBatchQuotesJSON", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: sampleDataPath)) else { XCTFail(); return }
        let batchQuotesResponse = try? JSONDecoder().decode(BatchQuotesResponse.self, from: data)
        let quotes = batchQuotesResponse?.quotes
        
        QuoteController.shared.quotes = quotes
        
        let interactor = StockListInteractor()
        
        XCTAssertEqual(interactor.tableView(UITableView(), numberOfRowsInSection: 0), QuoteController.shared.quotes?.count)
    }
    
}
