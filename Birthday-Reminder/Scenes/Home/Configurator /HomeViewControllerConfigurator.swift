//
//  HomeViewControllerConfigurator.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 07/12/2022.
//

import UIKit

final class HomeViewControllerConfigurator {
    
    // bla bla bla
    class func createHomeVC(coordinator: HomeCoordinator!) -> UIViewController {
        let baseHomeViewController = UIStoryboard.dequeueViewController() as HomeViewController
        let baseSettingsBarButton = UIBarButtonItem.createButtonItem(
            .settings, target: baseHomeViewController, action: #selector(baseHomeViewController.settingsButtonClicked(_:)))
        let baseCreateBarButton = UIBarButtonItem.createButtonItem(
            .create, target: baseHomeViewController, action: #selector(baseHomeViewController.createButtonClicked(_:)))
        baseHomeViewController.coordinator = coordinator
        baseHomeViewController.navigationItem.setLeftBarButton(baseSettingsBarButton, animated: true)
        baseHomeViewController.navigationItem.setRightBarButton(baseCreateBarButton, animated: true)
        return baseHomeViewController
    }
    
}
