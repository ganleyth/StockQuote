//
//  StockDetailViewController.swift
//  StockQuote
//
//  Created by Thomas Ganley on 3/18/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import UIKit

class StockDetailViewController: UIViewController {
    
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var closeLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    
    var quote: Quote? {
        didSet {
            refreshUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshUI()
    }
    
    private func refreshUI() {
        guard isViewLoaded,
            let quote = quote else { return }
        symbolLabel.text = quote.symbol
        openLabel.text = String(format: "$%0.2f", arguments: [quote.open])
        closeLabel.text = String(format: "$%0.2f", arguments: [quote.close])
        highLabel.text = String(format: "$%0.2f", arguments: [quote.high])
        lowLabel.text = String(format: "$%0.2f", arguments: [quote.low])
        
        navigationItem.title = "\(quote.symbol) Details"
    }
}
