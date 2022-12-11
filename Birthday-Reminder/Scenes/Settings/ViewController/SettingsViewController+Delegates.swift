//
//  SettingsViewController+Delegates.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 10/12/2022.
//

import UIKit

extension SettingsViewController: SettingsViewControllerDelegates {
   
    func setNightMode(_ selectedMode: nightModeOptions!) {
        self.appSettings?.nightMode = selectedMode
    }
        
}

