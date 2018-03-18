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
    private var highString: String? = nil
    private var lowString: String? = nil
    private var openString: String? = nil
    private var closeString: String? = nil
    
    var price: Double {
        return Double(priceString) ?? 0.0
    }
    
    var high: Double {
        return Double(highString ?? "") ?? 0.0
    }
    
    var low: Double {
        return Double(lowString ?? "") ?? 0.0
    }
    
    var open: Double {
        return Double(openString ?? "") ?? 0.0
    }
    
    var close: Double {
        return Double(closeString ?? "") ?? 0.0
    }
    
    enum CodingKeys: String, CodingKey {
        case symbol = "1. symbol"
        case priceString = "2. price"
    }
    
    mutating func update(withDetailsDict dict: [String: String]) {
        guard let high = dict["2. high"],
            let low = dict["3. low"],
            let open = dict["1. open"],
            let close = dict["4. close"] else { return }
        
        self.highString = high
        self.lowString = low
        self.openString = open
        self.closeString = close
    }
}

extension Quote {
    
    init(symbol: String, priceString: String) {
        self.symbol = symbol
        self.priceString = priceString
    }
    
}
