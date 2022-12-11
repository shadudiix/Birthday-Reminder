//
//  AppSettingsEnums.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 10/12/2022.
//

import UIKit

enum activetedLanguageOptions: Int, CustomStringConvertible {

    case english
    case arabic
    var description: String {
        switch(self) {
            case .arabic:
                return "اللغة العربية"
            case .english:
                return "English"
        }
    }
    
}

enum nightModeOptions: Int, CustomStringConvertible {

    case system
    case enabled
    case disabled
    
    var description: String {
        switch(self) {
            case .system:
                return "System"
            case .enabled:
                return "Enabled"
            case .disabled:
                return "Disabled"
        }
    }
    
    var userInterfaceStyle: UIUserInterfaceStyle {
        switch(self) {
            case .system:
                return .unspecified
            case .enabled:
                return .dark
            case .disabled:
                return .light
        }
    }
}
