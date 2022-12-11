//
//  Coordinator.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 08/12/2022.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController! { get set }
    var childCoordinators: [Coordinator]! { get set }
    func configureRootViewController()
}

extension Coordinator {
    
    func popLastViewController(complectionHandler: @escaping () -> ()) {
        self.navigationController.popViewController(animated: true, complectionHandler: complectionHandler)
    }
    
    func showAlert(_ alertMessage: String!) {
        let baseAlert = UIAlertController(title: nil, message: alertMessage, preferredStyle: .alert)
        baseAlert.addAction(UIAlertAction(title: "OK", style: .default))
        self.navigationController.present(baseAlert, animated: true)
    }
    
    func showAlert(_ alertMessage: String!, handler: @escaping(Bool) -> ()) {
        let baseAlert = UIAlertController(title: nil, message: alertMessage, preferredStyle: .alert)
        baseAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            handler(false)
        }))
        baseAlert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { _ in
            handler(true)
        }))
        self.navigationController.present(baseAlert, animated: true)
    }
    
    func childDidFinshied(_ child: Coordinator!) {
        for(index, coordinator) in self.childCoordinators.enumerated() {
            if(coordinator === child) {
                self.childCoordinators.remove(at: index)
                break
            }
        }
    }
    
}

