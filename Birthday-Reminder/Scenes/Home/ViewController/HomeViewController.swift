//
//  HomeViewController.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 07/12/2022.
//

import UIKit

final class HomeViewController: BaseViewController {

    // MARK: - Properties
    
    var reminders: [Reminder]! = {
        var baseReminders: [Reminder]! = .init()
        baseReminders.reserveCapacity(32)
        return baseReminders
    }()
    
   
    let homeServices: HomeServices! =
        HomeServices.init()
    
    var appSettings: AppSettingsManager? {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            return nil
        }
        return sceneDelegate.appSettings
    }

    weak var coordinator: HomeCoordinator?

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.loadReminders()
  }
    
    // MARK: - Object Life Cycle
    
    deinit {
        print("deinit \(self)")
    }
    
    @objc func createButtonClicked(_ sender: UIBarButtonItem!) {
        self.coordinator?.pushCreateViewContoller(delegates: self)
    }
    
    @objc func settingsButtonClicked(_ sender: UIBarButtonItem!) {
        self.coordinator?.pushSettingsViewController()
    }
}

