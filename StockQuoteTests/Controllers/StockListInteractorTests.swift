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
    
    lazy var sut = StockListInteractor()
    
    override func setUp() {
        let bundle = Bundle(for: type(of: self))
        guard let sampleDataPath = bundle.path(forResource: "SampleBatchQuotesJSON", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: sampleDataPath)) else { XCTFail(); return }
        let batchQuotesResponse = try? JSONDecoder().decode(BatchQuotesResponse.self, from: data)
        let quotes = batchQuotesResponse?.quotes
        
        QuoteController.shared.quotes = quotes
    }
    
    func test_Interactor_UsesBatchQuotesDataForRowCount() {
        XCTAssertEqual(sut.tableView(UITableView(), numberOfRowsInSection: 0), QuoteController.shared.quotes?.count)
    }
    
    func test_Interactor_PopulatesCellWithStockSymbolAndPrice() {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "listVC") as? StockListViewController else {
            XCTFail()
            return
        }
        vc.loadViewIfNeeded()
        guard let tableView = vc.tableView else { XCTFail(); return }
        let cell0 = sut.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        let cell1 = sut.tableView(tableView, cellForRowAt: IndexPath(row: 1, section: 0))
        let cell2 = sut.tableView(tableView, cellForRowAt: IndexPath(row: 2, section: 0))
        
        XCTAssertEqual(cell0.textLabel?.text, QuoteController.shared.quotes?[0].symbol)
        XCTAssertEqual(cell1.textLabel?.text, QuoteController.shared.quotes?[1].symbol)
        XCTAssertEqual(cell2.textLabel?.text, QuoteController.shared.quotes?[2].symbol)
        
        let displayPrice0 = String(format: "$%0.2f", arguments: [(QuoteController.shared.quotes?[0].price ?? 0)])
        let displayPrice1 = String(format: "$%0.2f", arguments: [(QuoteController.shared.quotes?[1].price ?? 0)])
        let displayPrice2 = String(format: "$%0.2f", arguments: [(QuoteController.shared.quotes?[2].price ?? 0)])
        
        XCTAssertEqual(cell0.detailTextLabel?.text, displayPrice0)
        XCTAssertEqual(cell1.detailTextLabel?.text, displayPrice1)
        XCTAssertEqual(cell2.detailTextLabel?.text, displayPrice2)
    }
    
}
