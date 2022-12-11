//
//  UIStoryboard+Ext.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 08/12/2022.
//

import UIKit

extension UIStoryboard {

    class func dequeueViewController<viewControllerType: UIViewController>() -> viewControllerType {
        let baseStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewControllerIdentifier = String(describing: viewControllerType.self)
        guard let viewController =
            baseStoryboard.instantiateViewController(withIdentifier: viewControllerIdentifier) as? viewControllerType else{
            fatalError("Cannot found withIdentifier: \(viewControllerIdentifier)")
        }
        return viewController
    }
    
}
