//
//  StatViewController.swift
//  BitCoinTool
//
//  Created by Pavel Bogart on 05/12/2017.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class StatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationTitle(title: "Stats")
        setupTableView()
        fetchMarketData()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self 
        tableView.register(StatCell.self, forCellReuseIdentifier: StatCell.reuseIdentifier)
        tableView.showsVerticalScrollIndicator = false
    }
    
    private func fetchMarketData() {
        DataManager.fetchMarketData(API.StatURL!) { (market, error) in
            print(market ?? "")
        }
    }
    
}

// MARK: - Table View Methods

extension StatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StatCell.reuseIdentifier, for: indexPath) as! StatCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
