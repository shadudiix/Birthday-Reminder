//
//  UIBarButtonItem+Ext.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 07/12/2022.
//

import UIKit

extension UIBarButtonItem {
    
    class func createButtonItem(_ baseImageName: UIImage.baseImagesNames!, target: AnyObject? = nil, action: Selector? = nil, tintColor: UIColor = .systemBrown) -> UIBarButtonItem {
        let baseButton = UIBarButtonItem()
        baseButton.target = target
        baseButton.action = action
        baseButton.image = UIImage.createBaseImage(baseImageName, color: tintColor)
        return baseButton
    }
    
    class func createButtonItem(_ baseTitle: String!, target: AnyObject? = nil, action: Selector? = nil) -> UIBarButtonItem {
        let baseButton = UIBarButtonItem()
        baseButton.target = target
        baseButton.action = action
        baseButton.title = baseTitle
        return baseButton
    }
}
