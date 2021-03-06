//
//  BatchQuotes.swift
//  StockQuote
//
//  Created by Thomas Ganley on 3/13/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import Foundation

struct BatchQuotesResponse: Decodable {
    let quotes: [Quote]
    
    enum CodingKeys: String, CodingKey {
        case quotes = "Stock Quotes"
    }
}
