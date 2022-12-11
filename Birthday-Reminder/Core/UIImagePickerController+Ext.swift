//
//  UIImagePickerController+Ext.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 10/12/2022.
//

import UIKit

extension UIImagePickerController {
    
    func saveSelectedImageFromPicker(_ imageName: String!, imageData: Data!) throws -> String! {
        guard let doucmentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
            fatalError("Cannot Deque doucmentDirectory")
        }
        
        let localPath = "\(doucmentDirectory)/\(imageName!)"
        print(localPath)
        if #available(iOS 16.0, *) {
            try imageData.write(to: URL.init(filePath: localPath))
        } else {
            try imageData.write(to: URL.init(fileURLWithPath: localPath))
        }
        return localPath
    }

}

