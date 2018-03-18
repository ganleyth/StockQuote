//
//  QuoteController.swift
//  StockQuote
//
//  Created by Thomas Ganley on 3/14/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import Foundation

class QuoteController {
    
    var quotes: [Quote]?
    
    static let shared = QuoteController()
    
    lazy var networkController: NetworkControllerProtocol = NetworkController.shared
    
    func fetchBatchQuotes(forSymbols symbols: [String], completion: @escaping () -> Void) {
        let urlParameters = [
            Constants.NetworkController.functionKey: Constants.NetworkController.batchQuotesFunction,
            Constants.NetworkController.symbolsKey: symbols.joined(separator: ","),
            Constants.NetworkController.apiKeyKey: Constants.NetworkController.apiKey
        ]
        
        guard let baseURL = URL(string: Constants.NetworkController.baseURL),
            let url = networkController.url(byAdding: urlParameters, to: baseURL) else { completion(); return }
        
        networkController.performGETRequest(for: url) { [weak self] (data, error) in
            defer { DispatchQueue.main.async { completion() } }
            guard let this = self else { return }
            if let error = error { print("Error performing GET: \(error.localizedDescription)"); return }
            guard let data = data else { print("No data returned from GET"); return }
            
            let batchQuotesResponse: BatchQuotesResponse
            do {
                batchQuotesResponse = try JSONDecoder().decode(BatchQuotesResponse.self, from: data)
            } catch {
                print("Could not decode data into a batch quotes response: \(error.localizedDescription)")
                return
            }
            
            DispatchQueue.main.async {
                this.quotes = batchQuotesResponse.quotes
            }
        }
    }
    
    func fetchQuoteDetails(forSymbol symbol: String, completion: @escaping (Quote?) -> Void) {
        
    }
}

protocol NetworkControllerProtocol {
    func performGETRequest(for url: URL, completion: @escaping (Data?, Error?) -> Void)
    func url(byAdding params: [String: String]?, to baseURL: URL) -> URL?
}

extension NetworkController: NetworkControllerProtocol {}
