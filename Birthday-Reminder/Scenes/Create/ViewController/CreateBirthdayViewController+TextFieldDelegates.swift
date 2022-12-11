//
//  CreateBirthdayViewController+TextFieldDelegates.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 08/12/2022.
//

import UIKit

extension CreateBirthdayViewController: UITextFieldDelegate {
    
    // MARK: - UITextField Delegates
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        switch(textField) {
            case self.birthdayTableView.personNameTextField:
                if(self.birthdayTableView.mobileNumberTextField.canBecomeFirstResponder) {
                    self.birthdayTableView.mobileNumberTextField.becomeFirstResponder()
                }
            default: break
        }
        return true
    }
    
    //TODO set given name and mobile number Build image picker, safe image location
}

