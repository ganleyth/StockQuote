//
//  NetworkController.swift
//  StockQuote
//
//  Created by Thomas Ganley on 3/14/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import Foundation

class NetworkController {
    
    static func url(byAdding params: [String: String]?, to baseURL: URL) -> URL? {
        let queryItems = params?.map({ URLQueryItem(name: $0.key, value: $0.value) })
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        components?.queryItems = queryItems
        
        return components?.url
    }
    
}
