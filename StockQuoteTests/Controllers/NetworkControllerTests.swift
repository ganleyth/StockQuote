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
        
        guard let url = NetworkController.shared.url(byAdding: params, to: baseURL),
            let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { XCTFail(); return }
        
        let returnedHost = components.host
        
        guard let returnedQueryItems = components.queryItems else { XCTFail(); return }
        var returnedParams: [String: String] = [:]
        returnedQueryItems.forEach({ returnedParams[$0.name] = $0.value })
        
        XCTAssertEqual(returnedHost, "testURL.com")
        XCTAssertEqual(returnedParams["param1"], "value1")
        XCTAssertEqual(returnedParams["param2"], "value2")
    }
    
    func test_WhenIssuedGETRequest_DataAndErrorAreHandled() {
        let bundle = Bundle(for: type(of: self))
        guard let sampleDataPath = bundle.path(forResource: "SampleBatchQuotesJSON", ofType: "json"),
            let url = URL(string: "https://testURL.com") else { XCTFail(); return }
        
        let data = try? Data(contentsOf: URL(fileURLWithPath: sampleDataPath))

        let session = MockURLSession(data: data, urlResponse: nil, error: NSError(domain: "test", code: 99, userInfo: nil))
        NetworkController.shared.session = session
        
        let expectation = XCTestExpectation()
        NetworkController.shared.performGETRequest(for: url) { (responseData, responseError) in
            XCTAssertEqual(data, responseData)
            XCTAssertEqual((responseError as NSError?)?.code, 99)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}

extension NetworkControllerTests {
    
    class MockURLSession: SessionProtocol {
        
        private let dataTask: MockTask
        
        init(data: Data?, urlResponse: URLResponse?, error: Error?) {
            self.dataTask = MockTask(data: data, urlResponse: urlResponse, error: error)
        }
        
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            
            dataTask.completionHandler = completionHandler
            return dataTask
        }
    }
    
    class MockTask: URLSessionDataTask {
        
        private let data: Data?
        private let urlResponse: URLResponse?
        private let responseError: Error?
        
        var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
        
        init(data: Data?, urlResponse: URLResponse?, error: Error?) {
            self.data = data
            self.urlResponse = urlResponse
            self.responseError = error
        }
        
        override func resume() {
            DispatchQueue.main.async { [weak self] in
                guard let this = self else { XCTFail(); return }
                this.completionHandler?(this.data, this.urlResponse, this.responseError)
            }
        }
    }
    
}
