//
//  Quote.swift
//  StockQuote
//
//  Created by Thomas Ganley on 3/13/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import Foundation

struct Quote: Decodable {
    let symbol: String
    private let priceString: String
    
    var price: Double {
        return Double(priceString) ?? 0.0
    }
    
    enum CodingKeys: String, CodingKey {
        case symbol = "1. symbol"
        case priceString = "2. price"
    }
}
