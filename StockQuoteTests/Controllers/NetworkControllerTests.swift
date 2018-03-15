//
//  NetworkControllerTests.swift
//  StockQuoteTests
//
//  Created by Thomas Ganley on 3/14/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import XCTest
@testable import StockQuote

class NetworkControllerTests: XCTestCase {
    
    func test_URLBuilder_WhenGivenBaseURLAndParams_BuildsCorrectURL() {
        guard let baseURL = URL(string: "https://testURL.com") else { XCTFail(); return }
        let params = [
            "param1": "value1",
            "param2": "value2"
        ]
        
        guard let url = NetworkController.url(byAdding: params, to: baseURL) else { XCTFail(); return }
    }
    
}
