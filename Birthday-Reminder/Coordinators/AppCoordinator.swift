//
//  AppCoordinator.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 08/12/2022.
//

import UIKit

final class AppCoordinator: Coordinator {

    // MARK: - Properties
    
    var navigationController: UINavigationController!
    var childCoordinators: [Coordinator]! = .init()

    // MARK: - Initialization
    
    init(navigationController: UINavigationController!) {
        self.navigationController = navigationController
        self.setupNavigationController()
    }
    
    private func setupNavigationController() {
        self.navigationController.navigationBar.tintColor = .systemBrown
    }
    
    // MARK: - Object Life Cycle
    
    deinit {
        print("deinit \(self)")
    }
    
    // MARK: - Functions
    
    func configureRootViewController() {
        let baseHomeCoordinator = HomeCoordinator.init(parentCoordinator: self, navigationController: self.navigationController)
        baseHomeCoordinator.configureRootViewController()
        self.childCoordinators.append(baseHomeCoordinator)
    }
    
}

