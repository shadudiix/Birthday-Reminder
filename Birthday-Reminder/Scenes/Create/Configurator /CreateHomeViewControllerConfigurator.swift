//
//  CreateHomeViewControllerConfigurator.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 08/12/2022.
//

import UIKit

final class CreateBirthdayViewControllerConfigurator {
    
    class func createBirthdayCreateViewController(delegates: ReminderCreatedDelegates!, parentCoordinator: HomeCoordinator!) -> UIViewController {
        let baseViewController = UIStoryboard.dequeueViewController() as CreateBirthdayViewController
        let baseDoneButton = UIBarButtonItem.createButtonItem(
            "Done", target: baseViewController, action: #selector(baseViewController.doneButtonClicked(_:))
        )
        baseViewController.parentCoordinator = parentCoordinator
        baseViewController.delegates = delegates
        baseViewController.navigationItem.setRightBarButton(baseDoneButton, animated: true)
        baseDoneButton.isEnabled = false
        return baseViewController
        
    }
    
}
