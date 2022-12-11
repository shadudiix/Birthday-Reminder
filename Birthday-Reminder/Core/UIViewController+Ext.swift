//
//  UIViewController+Ext.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 10/12/2022.
//

import UIKit


extension UIViewController{

    func showLoading() {
        let baseLoadingView = BaseLoadingView()
        self.view.addSubview(baseLoadingView)
        let baseLoadingViewConstraints = [
            baseLoadingView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
            baseLoadingView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
        ]
        NSLayoutConstraint.activate(baseLoadingViewConstraints)
        self.view.isUserInteractionEnabled = false
    }
    
    func hideLoading() {
        self.view.subviews.first(where: {$0.isKind(of: BaseLoadingView.self)})?.removeFromSuperview()
        self.view.isUserInteractionEnabled = true
    }
    
    func callPhoneByNumber(_ reminder: Reminder!, handler: ((Bool) -> ())?) {
        guard let telPhoneURL = URL(string: reminder.mobileNumber), UIApplication.shared.canOpenURL(telPhoneURL) == true  else {
            handler?(false)
            return
        }
        handler?(true)
        UIApplication.shared.open(telPhoneURL)
    }
}
