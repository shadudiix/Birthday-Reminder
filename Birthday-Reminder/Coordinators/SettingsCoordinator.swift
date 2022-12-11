//
//  SettingsCoordinator.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 08/12/2022.
//

import UIKit

final class SettingsCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController!
    
    var childCoordinators: [Coordinator]!
    
    private weak var parentCoordinator: AppCoordinator?
    
    // MARK: - Initialization
    
    init(parentCoordinator: AppCoordinator!, navigationController: UINavigationController!) {
        self.navigationController = navigationController
    }
    
    // MARK: - Object Life Cycle
    
    deinit {
        print("deinit \(self)")
    }
    
    // MARK: - Functions
    
    func configureRootViewController() {
        let baseSettingsViewController = SettingsViewControllerConfigurator.createSettingsVC(coordinator: self)
        self.navigationController.pushViewController(baseSettingsViewController, animated: true)
    }
    
    func pushNightModeViewController(delegates: SettingsViewControllerDelegates!, _ activeMode: nightModeOptions!) {
        let baseNightModesViewController = UIStoryboard.dequeueViewController() as NightModeViewController
        baseNightModesViewController.delegates = delegates
        baseNightModesViewController.activeMode = activeMode
        self.navigationController.pushViewController(baseNightModesViewController, animated: true)
    }
    
}

