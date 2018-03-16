//
//  StockListInteractor.swift
//  StockQuote
//
//  Created by Thomas Ganley on 3/15/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import UIKit

class StockListInteractor: NSObject, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return QuoteController.shared.quotes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell") else { return UITableViewCell() }
        
        let quote = QuoteController.shared.quotes?[indexPath.row]
        cell.textLabel?.text = quote?.symbol
        cell.detailTextLabel?.text = String(format: "$%0.2f", arguments: [quote?.price ?? 0])
        
        return cell
    }
}
