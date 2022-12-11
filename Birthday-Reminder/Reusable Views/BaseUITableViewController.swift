//
//  BaseUITableViewController.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 08/12/2022.
//

import UIKit

class BaseUITableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableViewController()
    }
    
    private func setupTableViewController() {
        self.view.backgroundColor = .systemGroupedBackground
    }
}
