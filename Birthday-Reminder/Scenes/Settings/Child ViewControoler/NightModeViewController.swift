//
//  NightModeViewController.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 10/12/2022.
//

import UIKit

final class NightModeViewController: BaseUITableViewController {
    
    // MARK: - Properties
    
    var activeMode: nightModeOptions!
    
    weak var delegates: SettingsViewControllerDelegates?
    
    // MARK: - View Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let indexPath = IndexPath.init(row: activeMode.rawValue, section: 0)
        guard let tableViewCell = self.tableView.cellForRow(at: indexPath) else { return }
        tableViewCell.accessoryType = .checkmark
    }
    
    // MARK: - Object Life Cycle
    
    deinit {
        print("deinit \(self)")
    }
    
    // MARK: - TableView Delegates

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.visibleCells.forEach { modeCell in
            modeCell.accessoryType = .none
        }
        
        guard let tableViewCell = tableView.cellForRow(at: indexPath) else { return }
        tableViewCell.accessoryType = .checkmark
        
        let nightModeOption = nightModeOptions(rawValue: indexPath.row)
        delegates?.setNightMode(nightModeOption)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
