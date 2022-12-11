//
//  SettingsViewController.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 07/12/2022.
//

import UIKit

final class SettingsViewController: BaseUITableViewController {
    
    // MARK: - Properties
    
    weak var coordinator: SettingsCoordinator?
    
    var appSettings: AppSettingsManager? {
        guard let sceneDelegates = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            return nil
        }
        return sceneDelegates.appSettings
    }

    private enum tableViewElements: Int {
        case nightMode
    }
    
    private func setupView() {
        
        let nightModeIndexPath = IndexPath(row: 0, section: 0)
        if let nightModeCell = self.tableView.cellForRow(at: nightModeIndexPath) {
            nightModeCell.detailTextLabel?.text = appSettings?.nightMode.description
        }
        
    }
    
    // MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupView()
    }
    
    // MARK: - Object Life Cycle
    
    deinit {
        print("deinit \(self)")
    }
    
    // MARK: - TableView Delegates
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.processCellClicks(indexPath)
    }

    private func processCellClicks(_ indexPath: IndexPath) {
        switch(indexPath.row) {
            case tableViewElements.nightMode.rawValue:
                self.coordinator?.pushNightModeViewController(delegates: self, self.appSettings?.nightMode)
        default:
            fatalError("Unknown Selection")
        }
    }

}
