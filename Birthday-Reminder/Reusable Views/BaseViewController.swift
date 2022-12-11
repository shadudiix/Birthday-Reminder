//
//  BaseViewController.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 07/12/2022.
//

import UIKit
 
class BaseViewController: UIViewController {
    
    private lazy var safeArea: UILayoutGuide = {
        return self.view.safeAreaLayoutGuide
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewController()
    }
    
    private func setupViewController() {
        
        self.view.backgroundColor = .systemGroupedBackground
        
    }
    
    func showToast(_ toastMessage: String!) {
        
        let baseToastView = BaseToastView(toastMessage)
        self.view.addSubview(baseToastView)
        let toastConstraints = [
            baseToastView.topAnchor.constraint(greaterThanOrEqualTo: self.safeArea.topAnchor, constant: 15),
            baseToastView.bottomAnchor.constraint(equalTo: self.safeArea.bottomAnchor, constant: -15),
            baseToastView.leadingAnchor.constraint(equalTo: self.safeArea.leadingAnchor, constant: 15),
            baseToastView.trailingAnchor.constraint(equalTo: self.safeArea.trailingAnchor, constant: -15),
        ]
        NSLayoutConstraint.activate(toastConstraints)
        
        UIView.animate(withDuration: 1.25, delay: 0.00, options: [.curveEaseInOut]) {
            baseToastView.alpha = 1.00
        } completion: {isCompleted in
            if(isCompleted) {
                UIView.animate(withDuration: 1.25, delay: 3.00) {
                    baseToastView.alpha = 0.00
                } completion: { isCompleted in
                    if(isCompleted) {
                        baseToastView.removeFromSuperview()
                    }
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
}
