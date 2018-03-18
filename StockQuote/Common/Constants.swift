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
        static let apiKeyKey = "apikey"
        static let baseURL = "https://www.alphavantage.co/query"
        static let functionKey = "function"
        static let intervalKey = "interval"
        static let outputSizeKey = "outputsize"
        static let symbolKey = "symbol"
        static let symbolsKey = "symbols"
        
        static let apiKey = "UE9RIHBB84K88GVU"
        static let batchQuotesFunction = "BATCH_STOCK_QUOTES"
        static let compact = "compact"
        static let oneMin = "1min"
        static let timeSeriesFunction = "TIME_SERIES_INTRADAY"
    }
    
}
