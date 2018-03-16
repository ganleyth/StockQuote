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
}
