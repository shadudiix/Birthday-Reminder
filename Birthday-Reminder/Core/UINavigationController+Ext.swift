//
//  UINavigationController+Ext.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 10/12/2022.
//

import UIKit

extension UINavigationController {
    
    func popViewController(animated: Bool, complectionHandler: @escaping() -> ()) {
        self.popViewController(animated: true)
        if animated == true, let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                complectionHandler()
            }
        } else {
            complectionHandler()
        }
    }
    
}

