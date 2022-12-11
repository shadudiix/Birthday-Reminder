//
//  HomeCoordinator.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 08/12/2022.
//

import UIKit
import ContactsUI

final class HomeCoordinator: NSObject, Coordinator {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController!
    
    var childCoordinators: [Coordinator]! = .init()
    
    private weak var parentCoordinator: AppCoordinator?
    
    // MARK: - Initialization
    
    init(parentCoordinator: AppCoordinator! ,navigationController: UINavigationController!) {
        super.init()
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        self.navigationController.delegate = self
    }
    
    // MARK: - Object Life Cycle
    
    deinit {
        print("deinit \(self)")
    }
    
    // MARK: - Functions
    
    func configureRootViewController() {
        let baseHomeViewController = HomeViewControllerConfigurator.createHomeVC(coordinator: self)
        self.navigationController.pushViewController(baseHomeViewController, animated: true)
    }
    
    // MARK: - Create Action Sheet
    
    func pushCallActionSheet(_ handler: @escaping(Bool) -> ()) {
        let baseActionAlertSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        baseActionAlertSheet.addAction(UIAlertAction(title: "Call", style: .default, handler: { _ in
            handler(true)
        }))
        baseActionAlertSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            handler(false)
        }))
        self.navigationController.present(baseActionAlertSheet, animated: true)
    }
    
    // MARK: - Create View Controller Navigation
    
    func pushCreateViewContoller(delegates: ReminderCreatedDelegates!) {
        let baseCreateBirthdayViewController = CreateBirthdayViewControllerConfigurator.createBirthdayCreateViewController(delegates: delegates, parentCoordinator: self)
        self.navigationController.pushViewController(baseCreateBirthdayViewController, animated: true)
    }
    
    func pushImagePickerViewController(delegates: UIImagePickerControllerDelegate & UINavigationControllerDelegate) {
        let baseImagePicker = UIImagePickerController()
        baseImagePicker.delegate = delegates
        baseImagePicker.allowsEditing = false
        self.navigationController.present(baseImagePicker, animated: true)
    }
    
    func pushContactPickerViewController(delegates: CNContactPickerDelegate!) {
        let baseContactPickerViewController = ContectPickerViewController(delegates)
        self.navigationController.present(baseContactPickerViewController, animated: true)
    }
    
    
    // MARK: - Setttings View Controller Navigation
    
    func pushSettingsViewController() {
        let baseSettingsCoordinator: SettingsCoordinator = .init(parentCoordinator: parentCoordinator, navigationController: navigationController)
        baseSettingsCoordinator.configureRootViewController()
        self.childCoordinators.append(baseSettingsCoordinator)
    }
}

extension HomeCoordinator: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        if(navigationController.viewControllers.contains(fromViewController)) {
            return
        }
        if let settingsViewController = fromViewController as? SettingsViewController {
            self.childDidFinshied(settingsViewController.coordinator)
        }
    }
}
