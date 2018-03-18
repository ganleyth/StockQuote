//
//  StockListViewController.swift
//  StockQuote
//
//  Created by Thomas Ganley on 3/15/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import UIKit

class StockListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let interactor = StockListInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = interactor
        fetchStocks()
    }
    
    private func fetchStocks() {
        QuoteController.shared.fetchBatchQuotes(forSymbols: ["NKE", "GOOG", "MSFT", "FB", "AAPL"]) { [weak self] in
            guard let this = self else { return }
            this.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            guard let destVC = segue.destination as? StockDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow,
                let quote = QuoteController.shared.quotes?[indexPath.row]  else { return }
            
            QuoteController.shared.fetchQuoteDetails(for: quote, completion: { (returnQuote) in
                DispatchQueue.main.async {
                    destVC.quote = returnQuote
                }
            })
            
            destVC.quote = quote
        }
    }
}
