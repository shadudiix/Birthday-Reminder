//
//  HomeViewController+ReminderCreatedDelegates.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 08/12/2022.
//

import UIKit

extension HomeViewController: ReminderCreatedDelegates {
    
    func createdReminder(_ reminder: Reminder!) {
        self.reminders.append(reminder)
        self.coordinator?.popLastViewController(complectionHandler: { [weak self] in
            guard let self = self else { return }
            self.insertNewRowToTableView()
            self.showToast("Reminder created successfully")
        })
    }
}
