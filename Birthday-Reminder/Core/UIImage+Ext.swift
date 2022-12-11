//
//  UIImage+Ext.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 07/12/2022.
//

import UIKit

extension UIImage {
    
    enum baseImagesNames: String {
        case create = "plus"
        case home = "house.fill"
        case settings = "gear"
        case search = "magnifyingglass"
        case person = "person.fill"
        case trash = "trash.fill"
        case call = "phone.fill"
    }
    
    class func createBaseImage(_ baseImageName: baseImagesNames!, color: UIColor = .systemBrown) -> UIImage? {
        let baseUIImage = UIImage(systemName: baseImageName.rawValue)?.withTintColor(color, renderingMode: .alwaysOriginal)
        return baseUIImage
    }
    
}
