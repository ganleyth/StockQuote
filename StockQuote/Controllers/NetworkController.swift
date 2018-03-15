//
//  NetworkController.swift
//  StockQuote
//
//  Created by Thomas Ganley on 3/14/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import Foundation

class NetworkController {
    
    static let shared = NetworkController()
    
    lazy var session: SessionProtocol = URLSession.shared
    
    func performGETRequest(for url: URL, completion: @escaping (Data?, Error?) -> Void) {
        session.dataTask(with: url) { (data, _, error) in
            completion(data, error)
        }.resume()
    }
    
    func url(byAdding params: [String: String]?, to baseURL: URL) -> URL? {
        let queryItems = params?.map({ URLQueryItem(name: $0.key, value: $0.value) })
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        components?.queryItems = queryItems
        
        return components?.url
    }
    
}

protocol SessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: SessionProtocol {}
