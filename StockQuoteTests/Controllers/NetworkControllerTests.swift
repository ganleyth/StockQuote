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
        
        guard let url = NetworkController.url(byAdding: params, to: baseURL),
            let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { XCTFail(); return }
        
        let returnedHost = components.host
        
        guard let returnedQueryItems = components.queryItems else { XCTFail(); return }
        var returnedParams: [String: String] = [:]
        returnedQueryItems.forEach({ returnedParams[$0.name] = $0.value })
        
        XCTAssertEqual(returnedHost, "testURL.com")
        XCTAssertEqual(returnedParams["param1"], "value1")
        XCTAssertEqual(returnedParams["param2"], "value2")
    }
    
}
