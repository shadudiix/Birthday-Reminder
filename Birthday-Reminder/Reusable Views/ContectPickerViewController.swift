//
//  ContectPickerViewController.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 08/12/2022.
//

import ContactsUI

final class ContectPickerViewController: CNContactPickerViewController {
    
    init(_ delegates: CNContactPickerDelegate!) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegates
        self.displayedPropertyKeys =
        [
            CNContactGivenNameKey,
            CNContactPhoneNumbersKey,
            CNContactBirthdayKey,
      ]
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
