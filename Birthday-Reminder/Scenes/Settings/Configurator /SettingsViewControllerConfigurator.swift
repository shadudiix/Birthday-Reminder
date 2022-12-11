//
//  SettingsViewControllerConfigurator.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 07/12/2022.
//

import UIKit

final class SettingsViewControllerConfigurator {
    
    class func createSettingsVC(coordinator: SettingsCoordinator!) -> UIViewController {
        let baseSettingsViewController = UIStoryboard.dequeueViewController() as SettingsViewController
        baseSettingsViewController.coordinator = coordinator
        return baseSettingsViewController
    }
    
}

