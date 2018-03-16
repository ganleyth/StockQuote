//
//  Constants.swift
//  StockQuote
//
//  Created by Thomas Ganley on 3/15/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import Foundation

struct Constants {
    
    struct NetworkController {
        static let baseURL = "https://www.alphavantage.co/query"
        static let functionKey = "function"
        static let symbolsKey = "symbols"
        static let apiKeyKey = "apikey"
        
        static let apiKey = "UE9RIHBB84K88GVU"
        static let batchQuotesFunction = "BATCH_STOCK_QUOTES"
    }
    
}
